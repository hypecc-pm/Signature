#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/cpr.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/cpr.list"
        rm -f "/var/lib/signature/manifests/cpr.list"
    fi

    rm -rf /usr/local/include/cpr
    rm -rf /usr/local/lib/cmake/cpr
    rm -f /usr/local/lib/libcpr*

    echo "[cpr] Target libraries and manifest entries purged successfully."
}

main
