#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/pcap_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/the-tcpdump-group/libpcap.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
    cmake --build "${BUILD_DIR}/build" --parallel
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/pcap.list"
    rm -f "${MANIFEST}"

    if [ -f "/usr/local/include/pcap.h" ]
    then
        echo "/usr/local/include/pcap.h" > "${MANIFEST}"
    fi

    if [ -d "/usr/local/include/pcap" ]
    then
        find /usr/local/include/pcap -type f >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*pcap*" -type f >> "${MANIFEST}" 2>/dev/null || true

    rm -rf "${BUILD_DIR}"
    echo "[pcap] Library binaries and headers deployed successfully."
}

main
