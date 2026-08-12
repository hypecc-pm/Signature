#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/sqlite3.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/sqlite3.list"
        rm -f "/var/lib/signature/manifests/sqlite3.list"
    fi

    rm -f /usr/local/include/sqlite3.h
    rm -f /usr/local/include/sqlite3ext.h
    rm -f /usr/local/bin/sqlite3
    rm -f /usr/local/lib/libsqlite3*

    echo "[sqlite3] Target libraries and manifest entries purged successfully."
}

main
