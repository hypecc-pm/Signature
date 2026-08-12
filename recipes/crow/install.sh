#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/crow_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/CrowCpp/Crow.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DCROW_BUILD_EXAMPLES=OFF -DCROW_BUILD_TESTS=OFF
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/crow.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/crow" ]
    then
        find /usr/local/include/crow -type f > "${MANIFEST}"
    fi

    if [ -f "/usr/local/include/crow.h" ]
    then
        echo "/usr/local/include/crow.h" >> "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/Crow" ]
    then
        find /usr/local/lib/cmake/Crow -type f >> "${MANIFEST}"
    fi

    rm -rf "${BUILD_DIR}"
    echo "[crow] Header library deployed successfully."
}

main
