#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/stb.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/stb.list"
        rm -f "/var/lib/signature/manifests/stb.list"
    fi

    rm -rf /usr/local/include/stb

    echo "[stb] Target headers and manifest entries purged successfully."
}

main
