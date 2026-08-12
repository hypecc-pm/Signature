#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/imgui_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/ocornut/imgui.git "${BUILD_DIR}"
    cd "${BUILD_DIR}"

    g++ -shared -fPIC -O2 imgui.cpp imgui_draw.cpp imgui_tables.cpp imgui_widgets.cpp -o libimgui.so

    mkdir -p /usr/local/include/imgui
    cp *.h /usr/local/include/imgui/
    cp libimgui.so /usr/local/lib/

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/imgui.list"
    rm -f "${MANIFEST}"

    find /usr/local/include/imgui -type f > "${MANIFEST}"
    echo "/usr/local/lib/libimgui.so" >> "${MANIFEST}"

    cd /
    rm -rf "${BUILD_DIR}"
    echo "[imgui] Library binaries and headers deployed successfully."
}

main
