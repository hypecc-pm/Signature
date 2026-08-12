#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/yaml-cpp.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/yaml-cpp.list"
        rm -f "/var/lib/signature/manifests/yaml-cpp.list"
    fi

    rm -rf /usr/local/include/yaml-cpp
    rm -rf /usr/local/lib/cmake/yaml-cpp
    rm -f /usr/local/lib/libyaml-cpp*

    echo "[yaml-cpp] Target libraries and manifest entries purged successfully."
}

main
