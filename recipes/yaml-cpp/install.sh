#!/usr/bin/env bash
set -e

main()
{
    BUILD_DIR="/tmp/yaml_cpp_build"
    rm -rf "${BUILD_DIR}"

    git clone --depth 1 https://github.com/jbeder/yaml-cpp.git "${BUILD_DIR}"
    cmake -B "${BUILD_DIR}/build" -S "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DYAML_CPP_BUILD_TESTS=OFF
    cmake --build "${BUILD_DIR}/build" --parallel
    cmake --install "${BUILD_DIR}/build"

    mkdir -p /var/lib/signature/manifests
    MANIFEST="/var/lib/signature/manifests/yaml-cpp.list"
    rm -f "${MANIFEST}"

    if [ -d "/usr/local/include/yaml-cpp" ]
    then
        find /usr/local/include/yaml-cpp -type f > "${MANIFEST}"
    fi

    if [ -d "/usr/local/lib/cmake/yaml-cpp" ]
    then
        find /usr/local/lib/cmake/yaml-cpp -type f >> "${MANIFEST}"
    fi

    find /usr/local/lib -name "*yaml-cpp*" -type f >> "${MANIFEST}" 2>/dev/null || true

    rm -rf "${BUILD_DIR}"
    echo "[yaml-cpp] Library binaries and headers deployed successfully."
}

main
