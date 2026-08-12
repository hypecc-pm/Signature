#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/crow.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/crow.list"
        rm -f "/var/lib/signature/manifests/crow.list"
    fi

    rm -rf /usr/local/include/crow
    rm -f /usr/local/include/crow.h
    rm -rf /usr/local/lib/cmake/Crow

    echo "[crow] Target headers and manifest entries purged successfully."
}

main
