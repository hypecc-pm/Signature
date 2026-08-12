#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/ftxui.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/ftxui.list"
        rm -f "/var/lib/signature/manifests/ftxui.list"
    fi

    rm -rf /usr/local/include/ftxui
    rm -rf /usr/local/lib/cmake/ftxui
    rm -f /usr/local/lib/libftxui*

    echo "[ftxui] Target libraries and manifest entries purged successfully."
}

main
