#!/usr/bin/env bash
set -e

main()
{
    if [ -f "/usr/local/include/nlohmann/json.hpp" ]
    then
        rm -f /usr/local/include/nlohmann/json.hpp
    fi

    if [ -d "/usr/local/include/nlohmann" ]
    then
        rmdir --ignore-fail-on-non-empty /usr/local/include/nlohmann 2>/dev/null || true
    fi

    if [ -f "/var/lib/signature/manifests/nlohmann-json.list" ]
    then
        rm -f /var/lib/signature/manifests/nlohmann-json.list
    fi

    echo "[nlohmann-json] Target headers and manifest entries purged successfully."
}

main
