#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/var/lib/signature/manifests/pcap.list" ]
    then
        while IFS= read -r file
        do
            if [ -f "${file}" ]
            then
                rm -f "${file}"
            fi
        done < "/var/lib/signature/manifests/pcap.list"
        rm -f "/var/lib/signature/manifests/pcap.list"
    fi

    rm -f /usr/local/include/pcap.h
    rm -rf /usr/local/include/pcap
    rm -f /usr/local/lib/libpcap*

    echo "[pcap] Target libraries and manifest entries purged successfully."
}

main
