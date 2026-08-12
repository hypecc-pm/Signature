#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/nob.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/nob.list"
        rm -f "/var/lib/signature/manifests/nob.list"
    fi

    rm -f /usr/local/include/nob.h

    echo "[nob] Target headers and manifest entries purged successfully."
}

main
