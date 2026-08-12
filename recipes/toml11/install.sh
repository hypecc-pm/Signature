#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/toml11_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/ToruNiina/toml11.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DTOML11_BUILD_TESTS=OFF
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/toml11.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/toml11" ]
    then
        find /usr/local/include/toml11 -type f > "${MANIFEST}"
    fi

    if [ -f "/usr/local/include/toml.hpp" ]
    then
        echo "/usr/local/include/toml.hpp" >> "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/toml11" ]
    then
        find /usr/local/lib/cmake/toml11 -type f >> "${MANIFEST}"
    fi

    rm -rf "${BUILD_DIR}"
    echo "[toml11] Header library deployed successfully."
}

main
