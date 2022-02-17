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
    REF 1b285a3977e635183691080c51fbeda42aaa96e3
    SHA512 85fde3d2b00df00b7f6de49a292ba9a944c1801c561a1aab74a6ee8c4b5cfac4a6bb425355432f94b48547819b8670f18e3fffd9b013e2d3c1a416d3ea20a444
    HEAD_REF camino
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

function(diligent_extract_with_patch_to archive_path destination_path patch_path)
    file(REMOVE_RECURSE ${destination_path})
    vcpkg_extract_source_archive_ex(
        OUT_SOURCE_PATH source_path
        ARCHIVE ${archive_path}
        PATCHES ${patch_path}
    )
    file(RENAME ${source_path} ${destination_path})
endfunction()

# --- diligent-core
vcpkg_download_distfile(DILIGENT_CORE
    URLS "https://github.com/daktronics/DiligentCore/archive/3cbb7b06dfafb6579eba19f485ad6a76cf3deccd.zip"
    FILENAME "diligent_core-ff057cf.zip"
    SHA512 ab80330d22b5272600f98ad855ec7a6f94b91cdf235891c94ac37de090472d763e4835a50cb12355fed951a851f5b9daf1f14ddcdbe3a5c2a04b4213ad35ae52
)
diligent_extract_to(${DILIGENT_CORE} ${diligent_source_path}/DiligentCore)

# --- glslang
vcpkg_download_distfile(GLSLANG
    URLS "https://github.com/daktronics/glslang/archive/49985573c6ee43365d2923ae38d080e4e9b60102.zip"
    FILENAME "glslang-4998557.zip"
    SHA512  a93c7dd7cd13d55ca4f2ae95e7f63b5db4d5f236f41a44ad8471255e546c47894afa70abfb662d90effb2d5d2c5c09f94348693ed5160b9b84dbd94678df4ce4
)
diligent_extract_to(${GLSLANG} ${diligent_source_path}/DiligentCore/ThirdParty/glslang)

# --- googletest
vcpkg_download_distfile(GOOGLETEST
    URLS "https://github.com/DiligentGraphics/googletest/archive/075810f7a20405ea09a93f68847d6e963212fa62.zip"
    FILENAME "googletest-075810f.zip"
    SHA512 b7d4bfacf1ad4935b3cda495f561c8a8b77a18c7410ed5765122b6196c9fb43befbfc29d5b750701db89569f581534bdabbae85fb427d107ee9a632be0421bab
)
diligent_extract_to(${GOOGLETEST} ${diligent_source_path}/DiligentCore/ThirdParty/googletest)

# --- spirv-cross
vcpkg_download_distfile(SPIRV_CROSS
    URLS "https://github.com/DiligentGraphics/SPIRV-Cross/archive/f61a33c8f4bbea37ac6fb3c1710288127dbc7e15.zip"
    FILENAME "SPIRV_Cross-f61a33c.zip"
    SHA512 d822d513a85176bf752c639be12a125e4b7cece00a07e961006f05945c76b4f49051531124f4ca4a8960cc064ee13977104d800a2b9058f4655049dc3fd26aba
)
diligent_extract_to(${SPIRV_CROSS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Cross)

# --- spirv headers
vcpkg_download_distfile(SPIRV_HEADERS
    URLS "https://github.com/DiligentGraphics/SPIRV-Headers/archive/5ea2d62e8c0ddd9e2a7d0ca5e3f2335e09e5f408.zip"
    FILENAME "SPIRV_Cross-5ea2d62.zip"
    SHA512 0f7c579389f4cb12e8b0a3c0f60cdf0e88372ac8819d3efac42f961bac4dea5bc51b3eb26bd7f82f09b49fd2ff1f0bdc9df1b24aa48ce5188891f64223b96bed
)
diligent_extract_to(${SPIRV_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Headers)

# --- spirv tools
vcpkg_download_distfile(SPIRV_TOOLS
    URLS "https://github.com/DiligentGraphics/SPIRV-Tools/archive/7308083707a4bffb62bcfbc721851033e5534bb7.zip"
    FILENAME "SPIRV_Tools-7308083-c.zip"
    SHA512 33e2a38959138d3630c254d67b785853538f8673923ea094bbd023a9272bf76efc98da94c5a03a1a8c59105b9c3fa8ab636084638f898714b281ba27d94d1e0d
)
diligent_extract_with_patch_to(${SPIRV_TOOLS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Tools "SPIRV-Tools-path-length.patch")
#diligent_extract_to(${SPIRV_TOOLS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Tools)

# --- vulkan headers
vcpkg_download_distfile(VULKAN_HEADERS
    URLS "https://github.com/DiligentGraphics/Vulkan-Headers/archive/fa27a13cf74080df2ad421a788299db1276f17a7.zip"
    FILENAME "Vulkan_Headers-fa27a13.zip"
    SHA512 b79bd70ddeac852e4e89bf4d736152d14338692549d87224d9ba494ff4108c5937fcfd9a1339cc7ca602f3e20e122bcbe82b5e2733b41f51e842501984f7e3b9
)
diligent_extract_to(${VULKAN_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/Vulkan-Headers)

# --- volk
vcpkg_download_distfile(VOLK
    URLS "https://github.com/DiligentGraphics/volk/archive/760a782f295a66de7391d6ed573d65e3fb1c8450.zip"
    FILENAME "volk-760a782.zip"
    SHA512 440bac52377b01c0c4a6adc5ee169e43fd85a9ed0470e0963567e15f1221820fbb78adf4cbfff00fb2c691807feeb3bab0e15ba7a0ed5437dc7c8ef594a56d54
)
diligent_extract_to(${VOLK} ${diligent_source_path}/DiligentCore/ThirdParty/VOLK)

# --- diligent-fx
vcpkg_download_distfile(DILIGENT_FX
    URLS "https://github.com/daktronics/DiligentFX/archive/1addf2e91ff2077cd18d026ea39899deeaa2acbd.zip"
    FILENAME "diligent_fx-1addf2e.zip"
    SHA512 895aaa006b8b61a32d038dce78b7adc553b5d97ceb75346a45da310f5fda182e4099013ab76e922cc21c3861ef9446731aed17f4f380e4d7d6b7a236855cdb6f
)
diligent_extract_to(${DILIGENT_FX} ${diligent_source_path}/DiligentFX)

# --- diligent-samples
vcpkg_download_distfile(DILIGENT_SAMPLES
    URLS "https://github.com/daktronics/DiligentSamples/archive/4e4a268a31619bd782beefc63b20923430fdb617.zip"
    FILENAME "diligent_samples-4e4a268.zip"
    SHA512 2fd217cdb253862584568fbd0b5c1f206a7692f7f9fe829b9cc4ad403da1970de56614a575af04445f24845c16e3e7e7f7e862a9b6c1c0ad7e2f17f2f7767cc0
)
diligent_extract_to(${DILIGENT_SAMPLES} ${diligent_source_path}/DiligentSamples)

# --- diligent-tools
vcpkg_download_distfile(DILIGENT_TOOLS
    URLS "https://github.com/daktronics/DiligentTools/archive/72e9f8995c912153d0351d8b374678a7c396fde3.zip"
    FILENAME "diligent_tools-72e9f89.zip"
    SHA512 47f76574e2b7cd2565207e110ab8e4933506a53f274ce0844ada9efb3c045820d4c77a43f5915db800f1bfc25daff31442e4866e3bb47b7432de5644aecf5dfd
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
        -DENABLE_GLSLANG_INSTALL=1
        -DSKIP_GLSLANG_INSTALL=0
        -DSKIP_SPIRV_TOOLS_INSTALL=0
        -DSPIRV_CROSS_SKIP_INSTALL=0
        -DSPIRV_TOOLS_BUILD_STATIC=1
        #-DDILIGENT_DEBUG=0
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
