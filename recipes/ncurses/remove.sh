#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/ncurses.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/ncurses.list"
        rm -f "/var/lib/signature/manifests/ncurses.list"
    fi

    rm -rf /usr/local/include/ncursesw
    rm -f /usr/local/include/ncurses.h
    rm -f /usr/local/include/curses.h
    rm -f /usr/local/lib/libncurses*

    echo "[ncurses] Target libraries and manifest entries purged successfully."
}

main
