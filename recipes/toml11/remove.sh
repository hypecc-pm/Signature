#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/toml11.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/toml11.list"
        rm -f "/var/lib/signature/manifests/toml11.list"
    fi

    rm -rf /usr/local/include/toml11
    rm -f /usr/local/include/toml.hpp
    rm -rf /usr/local/lib/cmake/toml11

    echo "[toml11] Target headers and manifest entries purged successfully."
}

main
