#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/raylib_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/raysan5/raylib.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=ON
    cmake --build "${BUILD_DIR}/build" --parallel
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/raylib.list"
    rm -f "${MANIFEST}"

    if [ -f "/usr/local/include/raylib.h" ]
    then
        echo "/usr/local/include/raylib.h" > "${MANIFEST}"
    fi

    if [ -f "/usr/local/include/raymath.h" ]
    then
        echo "/usr/local/include/raymath.h" >> "${MANIFEST}"
    fi

    if [ -f "/usr/local/include/rlgl.h" ]
    then
        echo "/usr/local/include/rlgl.h" >> "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/raylib" ]
    then
        find /usr/local/lib/cmake/raylib -type f >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*raylib*" -type f >> "${MANIFEST}" 2>/dev/null || true

    rm -rf "${BUILD_DIR}"
    echo "[raylib] Library binaries and headers deployed successfully."
}

main
