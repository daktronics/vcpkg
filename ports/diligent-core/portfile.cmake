# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CURRENT_INSTALLED_DIR     = ${VCPKG_ROOT_DIR}\installed\${TRIPLET}
#   DOWNLOADS                 = ${VCPKG_ROOT_DIR}\downloads
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#   VCPKG_TOOLCHAIN           = ON OFF
#   TRIPLET_SYSTEM_ARCH       = arm x86 x64
#   BUILD_ARCH                = "Win32" "x64" "ARM"
#   MSBUILD_PLATFORM          = "Win32"/"x64"/${TRIPLET_SYSTEM_ARCH}
#   DEBUG_CONFIG              = "Debug Static" "Debug Dll"
#   RELEASE_CONFIG            = "Release Static"" "Release DLL"
#   VCPKG_TARGET_IS_WINDOWS
#   VCPKG_TARGET_IS_UWP
#   VCPKG_TARGET_IS_LINUX
#   VCPKG_TARGET_IS_OSX
#   VCPKG_TARGET_IS_FREEBSD
#   VCPKG_TARGET_IS_ANDROID
#   VCPKG_TARGET_IS_MINGW
#   VCPKG_TARGET_EXECUTABLE_SUFFIX
#   VCPKG_TARGET_STATIC_LIBRARY_SUFFIX
#   VCPKG_TARGET_SHARED_LIBRARY_SUFFIX
#
# 	See additional helpful variables in /docs/maintainers/vcpkg_common_definitions.md

# # Specifies if the port install should fail immediately given a condition
# vcpkg_fail_port_install(MESSAGE "diligent-core currently only supports Linux and Mac platforms" ON_TARGET "Windows")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Daktronics/DiligentCore
    REF f5e045eff79f9f2c0c1936d67147ec69fcd00a83
    SHA512 4c91a4f0efabc9e23cce357a6696d10236036210823923763454d36fd25883d5773827c9ca37ee3e96daeff4cc47bfe252de991f6603b2b6642ff15b9e070070
    HEAD_REF vcpkg-v2.5-beta
)

#vcpkg_extract_source_archive_ex(
#    OUT_SOURCE_PATH SOURCE_PATH
#    ARCHIVE ${ARCHIVE}
#    # (Optional) A friendly name to use instead of the filename of the archive (e.g.: a version number or tag).
#    # REF 1.0.0
#    # (Optional) Read the docs for how to generate patches at:
#    # https://github.com/Microsoft/vcpkg/blob/master/docs/examples/patching.md
#    # PATCHES
#    #   001_port_fixes.patch
#    #   002_more_port_fixes.patch
#)

vcpkg_download_distfile(GLSLANG
    URLS "https://github.com/DiligentGraphics/glslang/archive/8a6bd158cf3941cd4d4ba95a55427080f04ac906.zip"
    FILENAME "glslang-8a6bd15.zip"
    SHA512 d517bf8d2c09006edeb9724aa81c4997602827c1b0728b58fe6848dfc817e2c9f2e0d8b2c2808703b0787bc18d6285e0daf5ebe90aa32e8e3668d869477d1a4b
)

vcpkg_extract_source_archive(
    ${GLSLANG}
    ${SOURCE_PATH}/ThirdParty/glslang
    # (Optional) A friendly name to use instead of the filename of the archive (e.g.: a version number or tag).
    # REF 1.0.0
    # (Optional) Read the docs for how to generate patches at:
    # https://github.com/Microsoft/vcpkg/blob/master/docs/examples/patching.md
    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

vcpkg_download_distfile(GOOGLETEST
    URLS "https://github.com/DiligentGraphics/googletest/archive/f3ef7e173fd0853069f16c4b5afc7e80a350604b.zip"
    FILENAME "googletest-f3ef7e1.zip"
    SHA512 a0f0411b0784fc6e2b68449c90a50cf65eeccbdbdcfb1ebbbbede2608a0b2a1a10738797c814a3fa5020eb9bcbcc811662e8a75d9c6a71021aa07e3092c5d2f1
)

vcpkg_download_distfile(SPIRV_CROSS
    URLS "https://github.com/DiligentGraphics/SPIRV-Cross/archive/b27bff01b9041a1f3e673252eaa55ee075515676.zip"
    FILENAME "SPIRV_Cross-b27bff0.zip"
    SHA512 9b0786971abe1385d914b3b6cad22327988fe6b18c281d5b580124af12be6e1d9257e2be40dcb111678991e74c44ccbe638f19e84aa01df0865ad82b7c4456e1
)

vcpkg_download_distfile(SPIRV_HEADERS
    URLS "https://github.com/DiligentGraphics/SPIRV-Headers/archive/faa570afbc91ac73d594d787486bcf8f2df1ace0.zip"
    FILENAME "SPIRV_Cross-faa570a.zip"
    SHA512 540a1a4f2f7379353c823074ab2001c572d402cadbd5e8d3c28c38de6d112a4766adb0540d68e9115f61d8dece54562ad3a0b54e89b31e35f85d21c24797b2a5
)

vcpkg_download_distfile(SPIRV_TOOLS
    URLS "https://github.com/DiligentGraphics/SPIRV-Tools/archive/6bf25d8ff9692565dcd85b0fff39025bc4ba98e6.zip"
    FILENAME "SPIRV_Tools-6bf25d8.zip"
    SHA512 81ee862f5cb0e3f2ceb432bcd31275be8e7377f20c70856ac1f9f1605352e6a07c023d522c3ca7a6fb1fa33d21a4eab18d505ad3bc7cc8dca00559b291a435f2
)

vcpkg_download_distfile(VULKAN_HEADERS
    URLS "https://github.com/DiligentGraphics/Vulkan-Headers/archive/ec2db85225ab410bc6829251bef6c578aaed5868.zip"
    FILENAME "Vulkan_Headers-ec2db85.zip"
    SHA512 fb771b18203bf33cfc06550b411737ee34f3d7fee73b35815d647ffd1b29a77eee02daf2553cf59dbfb19dadee57ab09cc1fc0f306a0a46ca91d8c723afe6c61
)

vcpkg_download_distfile(VOLK
    URLS "https://github.com/DiligentGraphics/volk/archive/d9281176c7f1883ac9622b58821fdbe79342f2db.zip"
    FILENAME "volk-d928117.zip"
    SHA512 b4c0671c18f953d0d23b1bce1d909af7f9d5d7c38d3ae585278b59634eb9d5f4111fe22b5e89906ad88716db167a5fabc925c13de57070326c3f6c9d53d5cb19
)

# # Check if one or more features are a part of a package installation.
# # See /docs/maintainers/vcpkg_check_features.md for more details
# vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
#   FEATURES # <- Keyword FEATURES is required because INVERTED_FEATURES are being used
#     tbb   WITH_TBB
#   INVERTED_FEATURES
#     tbb   ROCKSDB_IGNORE_PACKAGE_TBB
# )

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    -DDILIGENT_USE_VCPKG=1
)

vcpkg_install_cmake()

# Moves all .cmake files from /debug/share/diligent-core/ to /share/diligent-core/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/diligent-core)

# # Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/diligent-core RENAME copyright)
