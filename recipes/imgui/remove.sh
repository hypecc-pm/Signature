#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/imgui.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/imgui.list"
        rm -f "/var/lib/signature/manifests/imgui.list"
    fi

    rm -rf /usr/local/include/imgui
    rm -f /usr/local/lib/libimgui.so

    echo "[imgui] Target libraries and manifest entries purged successfully."
}

main
