#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/eigen_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://gitlab.com/libeigen/eigen.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/eigen.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/eigen3" ]
    then
        find /usr/local/include/eigen3 -type f > "${MANIFEST}"
    fi

    if [ -d "/usr/local/share/eigen3/cmake" ]
    then
        find /usr/local/share/eigen3/cmake -type f >> "${MANIFEST}"
    fi

    rm -rf "${BUILD_DIR}"
    echo "[eigen] Header library deployed successfully."
}

main
