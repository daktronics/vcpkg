# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/multi_index
    REF boost-${VERSION}
    SHA512 5445a8e2d1d6963b1e2b9469f0927c7ea93eb12b868feb401ec00f90230d180996ca6edc9ceaa886203f4940c6d6297cf30e1ada41305973ebc80fe55e5efee0
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
