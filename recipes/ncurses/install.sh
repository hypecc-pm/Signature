#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/ncurses_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/mirror/ncurses.git "${BUILD_DIR}"
    cd "${BUILD_DIR}"
    ./configure --prefix=/usr/local --with-shared --enable-widec --without-debug
    make -j$(nproc)
    make install

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/ncurses.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/ncursesw" ]
    then
        find /usr/local/include/ncursesw -type f > "${MANIFEST}"
    fi

    if [ -f "/usr/local/include/ncurses.h" ]
    then
        echo "/usr/local/include/ncurses.h" >> "${MANIFEST}"
    fi

    if [ -f "/usr/local/include/curses.h" ]
    then
        echo "/usr/local/include/curses.h" >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*ncurses*" -type f >> "${MANIFEST}" 2>/dev/null || true

    cd /
    rm -rf "${BUILD_DIR}"
    echo "[ncurses] Library binaries and headers deployed successfully."
}

main
