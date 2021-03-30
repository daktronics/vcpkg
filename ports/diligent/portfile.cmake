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

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO daktronics/DiligentEngine
    REF 07a483ac94fe4884de6f389a53d32bc7dcda002d
    SHA512 2ff716f367b58ca13860a1cae62fc700ed45ed8a022e9147ac16e9ad766199935b2c9af2cf4a2ca7b079a81684fe61fc8ce4b30e1ce7db3bc6c7247e68c6e434
    HEAD_REF vcpkg_patch
)

set(diligent_source_path ${SOURCE_PATH})

function(diligent_extract_to archive_path destination_path)
    file(REMOVE_RECURSE ${destination_path})
    vcpkg_extract_source_archive_ex(
        OUT_SOURCE_PATH source_path
        ARCHIVE ${archive_path}
    )
    file(RENAME ${source_path} ${destination_path})
endfunction()

# --- diligent-core
vcpkg_download_distfile(DILIGENT_CORE
    URLS "https://github.com/daktronics/DiligentCore/archive/55c5c1b54b7cc4007563d64f647aead16520b5d3.zip"
    FILENAME "diligent_core-55c5c1b.zip"
    SHA512 984a18225641a2fc9ddd1a0dd0ffaa81c4514349c5aecfe8a9adb98a746e7c7873207d411436b74a9edda129484f63c3c1e9ea17cdcafb33610a3acbafc0ae5d
)
diligent_extract_to(${DILIGENT_CORE} ${diligent_source_path}/DiligentCore)

# --- glslang
vcpkg_download_distfile(GLSLANG
    URLS "https://github.com/daktronics/glslang/archive/4ef8b72fc264829bea869818396fc664192cbad5.zip"
    FILENAME "glslang-4ef8b72.zip"
    SHA512  b36382d0df21b1661a22c7ce2da68c4c9f6fccf72caa454d0020dc2ab7bd9adb6e01cd35c2a5ccce73f9afa08fe5bc1b9ed005e90c3dc37c26485f338ee2a21d
)
diligent_extract_to(${GLSLANG} ${diligent_source_path}/DiligentCore/ThirdParty/glslang)

# --- googletest
vcpkg_download_distfile(GOOGLETEST
    URLS "https://github.com/DiligentGraphics/googletest/archive/f3ef7e173fd0853069f16c4b5afc7e80a350604b.zip"
    FILENAME "googletest-f3ef7e1.zip"
    SHA512 a0f0411b0784fc6e2b68449c90a50cf65eeccbdbdcfb1ebbbbede2608a0b2a1a10738797c814a3fa5020eb9bcbcc811662e8a75d9c6a71021aa07e3092c5d2f1
)
diligent_extract_to(${GOOGLETEST} ${diligent_source_path}/DiligentCore/ThirdParty/googletest)

# --- spirv-cross
vcpkg_download_distfile(SPIRV_CROSS
    URLS "https://github.com/DiligentGraphics/SPIRV-Cross/archive/b27bff01b9041a1f3e673252eaa55ee075515676.zip"
    FILENAME "SPIRV_Cross-b27bff0.zip"
    SHA512 9b0786971abe1385d914b3b6cad22327988fe6b18c281d5b580124af12be6e1d9257e2be40dcb111678991e74c44ccbe638f19e84aa01df0865ad82b7c4456e1
)
diligent_extract_to(${SPIRV_CROSS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Cross)

# --- spirv headers
vcpkg_download_distfile(SPIRV_HEADERS
    URLS "https://github.com/DiligentGraphics/SPIRV-Headers/archive/faa570afbc91ac73d594d787486bcf8f2df1ace0.zip"
    FILENAME "SPIRV_Cross-faa570a.zip"
    SHA512 540a1a4f2f7379353c823074ab2001c572d402cadbd5e8d3c28c38de6d112a4766adb0540d68e9115f61d8dece54562ad3a0b54e89b31e35f85d21c24797b2a5
)
diligent_extract_to(${SPIRV_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Headers)

# --- spirv tools
vcpkg_download_distfile(SPIRV_TOOLS
    URLS "https://github.com/DiligentGraphics/SPIRV-Tools/archive/6bf25d8ff9692565dcd85b0fff39025bc4ba98e6.zip"
    FILENAME "SPIRV_Tools-6bf25d8.zip"
    SHA512 81ee862f5cb0e3f2ceb432bcd31275be8e7377f20c70856ac1f9f1605352e6a07c023d522c3ca7a6fb1fa33d21a4eab18d505ad3bc7cc8dca00559b291a435f2
)

diligent_extract_to(${SPIRV_TOOLS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Tools)

# --- vulkan headers
vcpkg_download_distfile(VULKAN_HEADERS
    URLS "https://github.com/DiligentGraphics/Vulkan-Headers/archive/ec2db85225ab410bc6829251bef6c578aaed5868.zip"
    FILENAME "Vulkan_Headers-ec2db85.zip"
    SHA512 fb771b18203bf33cfc06550b411737ee34f3d7fee73b35815d647ffd1b29a77eee02daf2553cf59dbfb19dadee57ab09cc1fc0f306a0a46ca91d8c723afe6c61
)
diligent_extract_to(${VULKAN_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/Vulkan-Headers)

# --- volk
vcpkg_download_distfile(VOLK
    URLS "https://github.com/DiligentGraphics/volk/archive/d9281176c7f1883ac9622b58821fdbe79342f2db.zip"
    FILENAME "volk-d928117.zip"
    SHA512 b4c0671c18f953d0d23b1bce1d909af7f9d5d7c38d3ae585278b59634eb9d5f4111fe22b5e89906ad88716db167a5fabc925c13de57070326c3f6c9d53d5cb19
)
diligent_extract_to(${VOLK} ${diligent_source_path}/DiligentCore/ThirdParty/VOLK)

# --- diligent-fx
vcpkg_download_distfile(DILIGENT_FX
    URLS "https://github.com/daktronics/DiligentFX/archive/8a6e680658a1091a5d82f52bc0bb2dd909543da6.zip"
    FILENAME "diligent_fx-8a6e680.zip"
    SHA512 801dbc18dbdde1f95f969eae9cf4bf1633be2b7c9dc8da56b1a14ae5d76501137bc851e2bc3567a31991d401e3f715722768692fdaca33e8f9e17530380d362c
)
diligent_extract_to(${DILIGENT_FX} ${diligent_source_path}/DiligentFX)

# --- diligent-samples
vcpkg_download_distfile(DILIGENT_SAMPLES
    URLS "https://github.com/daktronics/DiligentSamples/archive/f19131365694930bcc269f4230b92723c31a6954.zip"
    FILENAME "diligent_samples-f191313.zip"
    SHA512 c536702f03915ffbee11b862ab28a311034ba1e6df9298049569400821202cf9914936531528db2f6090e9eee1c4e0475805ec556eb50dd025bfd69038e3a310
)
diligent_extract_to(${DILIGENT_SAMPLES} ${diligent_source_path}/DiligentSamples)

# --- diligent-tools
vcpkg_download_distfile(DILIGENT_TOOLS
    URLS "https://github.com/daktronics/DiligentTools/archive/044f3b78ce0ef8c83878d696e3fb94bcb14f3da6.zip"
    FILENAME "diligent_tools-044f3b7.zip"
    SHA512 1a239bbdb1f9f88264c4b4666b7d8cb4b4e227444fe2030e1ee013eb8e0aed17ff94a50fb4bd3bbcc8363b5553c15aac1442a8817e73bae857b0893829aa93d7
)
diligent_extract_to(${DILIGENT_TOOLS} ${diligent_source_path}/DiligentTools)

# --- imgui
vcpkg_download_distfile(IMGUI
    URLS "https://github.com/DiligentGraphics/imgui/archive/a8f04f5e05fe4d0bd6cd83bff3b0c3c4ec748535.zip"
    FILENAME "imgui-a8f04f5.zip"
    SHA512 a6adfde7e5ed58c8c1f7b786c78de14a4bbf3fb85238388dbe07bcbce89826bebeb3af58e707d678c15035505fe1e999498c8007593032197fd04020bd20d836
)
diligent_extract_to(${IMGUI} ${diligent_source_path}/DiligentTools/ThirdParty/imgui)

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
    #PREFER_NINJA # Disable this option if project cannot be built with Ninja
    DISABLE_PARALLEL_CONFIGURE # DiligentFX writes out shader stuff back to source :/
    OPTIONS
        -DDILIGENT_USE_VCPKG=1
        -DDILIGENT_NO_FORMAT_VALIDATION=1
        -DDILIGENT_INSTALL_CORE=1
        -DDILIGENT_INSTALL_PDB=0
        -DDILIGENT_BUILD_TOOLS=1
        -DDILIGENT_INSTALL_TOOLS=1
        -DDILIGENT_BUILD_FX=1
        -DDILIGENT_INSTALL_FX=1
        -DDILIGENT_BUILD_SAMPLES=0
        -DDILIGENT_BUILD_DEMOS=0
        -DENABLE_GLSLANG_INSTALL=1
        #-DENGINE_DLL=1
)

vcpkg_install_cmake()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/share/${PORT})

function(diligent_move_to source_glob destination_directory)
    file(GLOB glob_files LIST_DIRECTORIES false ${source_glob})
    foreach(glob_file ${glob_files})
        get_filename_component(glob_filename ${glob_file} NAME)
        file(RENAME ${glob_file} ${destination_directory}/${glob_filename})
    endforeach()
endfunction()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/${PORT})
diligent_move_to(${CURRENT_PACKAGES_DIR}/lib/cmake/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT})
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/${PORT}/spirv_cross_core)
diligent_move_to(${CURRENT_PACKAGES_DIR}/share/spirv_cross_core/cmake/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT}/spirv_cross_core)
diligent_move_to(${CURRENT_PACKAGES_DIR}/SPIRV-Tools/cmake/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/SPIRV-ToolsConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
diligent_move_to(${CURRENT_PACKAGES_DIR}/SPIRV-Tools-opt/cmake/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT})
diligent_move_to(${CURRENT_PACKAGES_DIR}/SPIRV-Tools-link/cmake/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT})
diligent_move_to(${CURRENT_PACKAGES_DIR}/SPIRV-Tools-reduce/cmake/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/diligent-config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
vcpkg_copy_pdbs()

# Moves all .cmake files from /debug/share/diligent-core/ to /share/diligent-core/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
message(STATUS "Packages:  ${CURRENT_PACKAGES_DIR}")
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/SPIRV-Tools)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/SPIRV-Tools-opt)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/SPIRV-Tools-link)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/SPIRV-Tools-reduce)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/spirv_cross_core)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/SPIRV-Tools)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/SPIRV-Tools-link)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/SPIRV-Tools-opt)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/SPIRV-Tools-reduce)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/DiligentTools)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/DiligentTools)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include/Shaders/Shadows)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/Shaders/Shadows)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/Licenses)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# # Handle copyright
file(INSTALL ${SOURCE_PATH}/License.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(RENAME ${CURRENT_PACKAGES_DIR}/Licenses ${CURRENT_PACKAGES_DIR}/share/${PORT}/licenses)
