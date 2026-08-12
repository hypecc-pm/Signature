#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/qt.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/qt.list"
        rm -f "/var/lib/signature/manifests/qt.list"
    fi

    rm -rf /usr/local/include/qt6
    rm -rf /usr/local/lib/cmake/Qt6
    rm -f /usr/local/lib/libQt6*

    echo "[qt] Target libraries and manifest entries purged successfully."
}

main
