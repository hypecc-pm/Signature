#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/ftxui_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/ArthurSonzogni/FTXUI.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
    cmake --build "${BUILD_DIR}/build" --parallel
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/ftxui.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/ftxui" ]
    then
        find /usr/local/include/ftxui -type f > "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/ftxui" ]
    then
        find /usr/local/lib/cmake/ftxui -type f >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*ftxui*" -type f >> "${MANIFEST}" 2>/dev/null || true

    rm -rf "${BUILD_DIR}"
    echo "[ftxui] Library binaries and headers deployed successfully."
}

main
