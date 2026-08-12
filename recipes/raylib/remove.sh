#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/raylib.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/raylib.list"
        rm -f "/var/lib/signature/manifests/raylib.list"
    fi

    rm -f /usr/local/include/raylib.h
    rm -f /usr/local/include/raymath.h
    rm -f /usr/local/include/rlgl.h
    rm -rf /usr/local/lib/cmake/raylib
    rm -f /usr/local/lib/libraylib*

    echo "[raylib] Target libraries and manifest entries purged successfully."
}

main
