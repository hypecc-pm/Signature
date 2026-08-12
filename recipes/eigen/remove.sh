#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/eigen.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/eigen.list"
        rm -f "/var/lib/signature/manifests/eigen.list"
    fi

    rm -rf /usr/local/include/eigen3
    rm -rf /usr/local/share/eigen3

    echo "[eigen] Target headers and manifest entries purged successfully."
}

main
