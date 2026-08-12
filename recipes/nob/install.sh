#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/nob_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/tsoding/nob.h.git "${BUILD_DIR}"
    
    mkdir -p /usr/local/include
    cp "${BUILD_DIR}/nob.h" /usr/local/include/nob.h

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/nob.list"
    rm -f "${MANIFEST}"

    echo "/usr/local/include/nob.h" > "${MANIFEST}"

    rm -rf "${BUILD_DIR}"
    echo "[nob] Header library deployed successfully."
}

main
