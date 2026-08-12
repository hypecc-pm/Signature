#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/fmt_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/fmtlib/fmt.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DFMT_TEST=OFF
    cmake --build "${BUILD_DIR}/build" --parallel
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/fmt.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/fmt" ]
    then
        find /usr/local/include/fmt -type f > "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/fmt" ]
    then
        find /usr/local/lib/cmake/fmt -type f >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*fmt*" -type f >> "${MANIFEST}" 2>/dev/null || true

    rm -rf "${BUILD_DIR}"
    echo "[fmt] Library binaries and headers deployed successfully."
}

main
