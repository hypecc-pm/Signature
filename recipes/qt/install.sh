#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/qt_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/qt/qtbase.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DQT_BUILD_EXAMPLES=OFF -DQT_BUILD_TESTS=OFF
    cmake --build "${BUILD_DIR}/build" --parallel
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/qt.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/qt6" ]
    then
        find /usr/local/include/qt6 -type f > "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/Qt6" ]
    then
        find /usr/local/lib/cmake/Qt6 -type f >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*Qt6*" -type f >> "${MANIFEST}" 2>/dev/null || true

    rm -rf "${BUILD_DIR}"
    echo "[qt] Library binaries and headers deployed successfully."
}

main
