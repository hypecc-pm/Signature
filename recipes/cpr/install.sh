#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/cpr_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/libcpr/cpr.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCPR_BUILD_TESTS=OFF
    cmake --build "${BUILD_DIR}/build" --parallel
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/cpr.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/cpr" ]
    then
        find /usr/local/include/cpr -type f > "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/cpr" ]
    then
        find /usr/local/lib/cmake/cpr -type f >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*cpr*" -type f >> "${MANIFEST}" 2>/dev/null || true

    rm -rf "${BUILD_DIR}"
    echo "[cpr] Library binaries and headers deployed successfully."
}

main
