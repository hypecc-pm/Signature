#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/sqlite_orm.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/sqlite_orm.list"
        rm -f "/var/lib/signature/manifests/sqlite_orm.list"
    fi

    rm -rf /usr/local/include/sqlite_orm
    rm -rf /usr/local/lib/cmake/sqlite_orm

    echo "[sqlite_orm] Target headers and manifest entries purged successfully."
}

main
