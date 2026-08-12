#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/sqlite3_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/sqlite/sqlite.git "${BUILD_DIR}"
    cd "${BUILD_DIR}"
    ./configure --prefix=/usr/local --enable-shared
    make -j$(nproc)
    make install

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/sqlite3.list"
    rm -f "${MANIFEST}"

    if [ -f "/usr/local/include/sqlite3.h" ]
    then
        echo "/usr/local/include/sqlite3.h" > "${MANIFEST}"
    fi

    if [ -f "/usr/local/include/sqlite3ext.h" ]
    then
        echo "/usr/local/include/sqlite3ext.h" >> "${MANIFEST}"
    fi

    if [ -f "/usr/local/bin/sqlite3" ]
    then
        echo "/usr/local/bin/sqlite3" >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*sqlite3*" -type f >> "${MANIFEST}" 2>/dev/null || true

    cd /
    rm -rf "${BUILD_DIR}"
    echo "[sqlite3] Library binaries and headers deployed successfully."
}

main
