#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/stb_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/nothings/stb.git "${BUILD_DIR}"

    mkdir -p /usr/local/include/stb
    cp "${BUILD_DIR}"/*.h /usr/local/include/stb/

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/stb.list"
    rm -f "${MANIFEST}"

    find /usr/local/include/stb -type f > "${MANIFEST}"

    rm -rf "${BUILD_DIR}"
    echo "[stb] Single-file header collection deployed successfully."
}

main
