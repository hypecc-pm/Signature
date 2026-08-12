#!/usr/bin/env bash
set -e

main()
{
    mkdir -p /usr/local/include/nlohmann
    mkdir -p /var/lib/signature/manifests

    curl -sSL "https://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp" -o /usr/local/include/nlohmann/json.hpp

    if [ -f "/usr/local/include/nlohmann/json.hpp" ]
    then
        chmod 644 /usr/local/include/nlohmann/json.hpp
        echo "/usr/local/include/nlohmann/json.hpp" > /var/lib/signature/manifests/nlohmann-json.list
        echo "/usr/local/include/nlohmann" >> /var/lib/signature/manifests/nlohmann-json.list
        echo "[nlohmann-json] Header payload deployed successfully."
    else
        echo "[nlohmann-json] Error: Failed to retrieve header binary."
        exit 1
    fi
}

main
