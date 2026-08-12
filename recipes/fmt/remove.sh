#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/fmt.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/fmt.list"
        rm -f "/var/lib/signature/manifests/fmt.list"
    fi

    rm -rf /usr/local/include/fmt
    rm -rf /usr/local/lib/cmake/fmt
    rm -f /usr/local/lib/libfmt*

    echo "[fmt] Target libraries and manifest entries purged successfully."
}

main
