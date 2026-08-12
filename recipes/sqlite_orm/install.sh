#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/sqlite_orm_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/fnc12/sqlite_orm.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/sqlite_orm.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/sqlite_orm" ]
    then
        find /usr/local/include/sqlite_orm -type f > "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/sqlite_orm" ]
    then
        find /usr/local/lib/cmake/sqlite_orm -type f >> "${MANIFEST}"
    fi

    rm -rf "${BUILD_DIR}"
    echo "[sqlite_orm] Header library deployed successfully."
}

main
