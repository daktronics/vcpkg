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
    REF 50f6b3107ce10861bc3b2edc19e01abd0663a2ce
    SHA512 977cf4a52aded7bbe5cbcbbf5926bcc4bacf4be6ce4447c024c0f97bf3a9d1e120a5dd7e1fb68aa33bc3cc817813bdd12a789d77eb4f94b520faeb8e9258765e
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
    URLS "https://github.com/daktronics/DiligentCore/archive/461fbd924403b52da2af36295391bed99fe5cefa.zip"
    FILENAME "diligent_core-461fbd9.zip"
    SHA512 d458da8a35f68d0232cc14dfe2be7bebdf4c4696e0f84f21b1787863d72925194841fa3a48b79e6fe3e3e2ae138c468c9364a6a0ea97cd8746da0df2c1fe6d9c
)
diligent_extract_to(${DILIGENT_CORE} ${diligent_source_path}/DiligentCore)

# --- glslang
vcpkg_download_distfile(GLSLANG
    URLS "https://github.com/daktronics/glslang/archive/88fd417b0bb7d91755961c70e846d274c182f2b0.zip"
    FILENAME "glslang-88fd417.zip"
    SHA512  a185062316abf2b7f70786ffe32d7f70a991d301c7a58deb7222afdd71a94ea25544facee227721faf464a45919d992a386a001d04b57a34f787208ec36a076a
)
diligent_extract_to(${GLSLANG} ${diligent_source_path}/DiligentCore/ThirdParty/glslang)

# --- googletest
vcpkg_download_distfile(GOOGLETEST
    URLS "https://github.com/DiligentGraphics/googletest/archive/e68764c147ea0dac1e8811925c531d937396878e.zip"
    FILENAME "googletest-e68764c.zip"
    SHA512 ce0c15043e360a365597bb965917ca3937c301ddfe44ba07bad1268a302a36903cf5219967208637ea92fca38655882211038bb77e82864ffd775ff137acf26f
)
diligent_extract_to(${GOOGLETEST} ${diligent_source_path}/DiligentCore/ThirdParty/googletest)

# --- spirv-cross
vcpkg_download_distfile(SPIRV_CROSS
    URLS "https://github.com/DiligentGraphics/SPIRV-Cross/archive/c77b09b57c27837dc2d41aa371ed3d236ce9ce47.zip"
    FILENAME "SPIRV_Cross-c77b09b-1.zip"
    SHA512 0dba7c014c3715958e52b876443ea46bf2c0aeefc26049e8c7347ba4e72118848b03fddbcc5b3a9529fb10dd6af515b1696bb9269eeb60319d999666b426dc2e
)
diligent_extract_to(${SPIRV_CROSS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Cross)

# --- spirv headers
vcpkg_download_distfile(SPIRV_HEADERS
    URLS "https://github.com/DiligentGraphics/SPIRV-Headers/archive/c214f6f2d1a7253bb0e9f195c2dc5b0659dc99ef.zip"
    FILENAME "SPIRV_Headers-c214f6f.zip"
    SHA512 fed6414a4693c62974f24c3cc1bcecf540fb4ff522860dac4e47a08ecae21dba57f35c382f92ace4eaf42c8723865b9dc6d8dc39e66a1666cbb00add9b288a39
)
diligent_extract_to(${SPIRV_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Headers)

# --- spirv tools
vcpkg_download_distfile(SPIRV_TOOLS
    URLS "https://github.com/DiligentGraphics/SPIRV-Tools/archive/00018e58af055a74fd88718af8cca8de34c25106.zip"
    FILENAME "SPIRV_Tools-00018e5.zip"
    SHA512 e1b2ec3985e5b9180e6ccf7fdbfd907f71eb49e8f0acccf1df4dc3622ad99d8a2663d4714f2e8d1a8e8538400f867ae1a03520f013fd7db8d7edc32c8e2ac695
)
diligent_extract_with_patch_to(${SPIRV_TOOLS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Tools "SPIRV-Tools-path-length.patch")
#diligent_extract_to(${SPIRV_TOOLS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Tools)

# --- vulkan headers
vcpkg_download_distfile(VULKAN_HEADERS
    URLS "https://github.com/DiligentGraphics/Vulkan-Headers/archive/b092b2fccc812453c1d0ec0a829eb8f34f174803.zip"
    FILENAME "Vulkan_Headers-b092b2f.zip"
    SHA512 04005400f25fce6452e5c03a5a98668127725e269c8bb2a85b24c1130c05202982b5bd9a27eba6276a7671429d7d50fb40f11b8238e2349c6635b6d9e76ec532
)
diligent_extract_to(${VULKAN_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/Vulkan-Headers)

# --- volk
vcpkg_download_distfile(VOLK
    URLS "https://github.com/DiligentGraphics/volk/archive/fd052833a74a3db60423af7fa825e4c77218e34f.zip"
    FILENAME "volk-fd05283.zip"
    SHA512 c137c63a5151a9d6e81e9f760c8695c87272b49e86a8083a2ebcd78ee939c91713b337623bbfc3ac261ab14bacccfbbc9ea3c00ab8c3d8aa57367654687d487f
)
diligent_extract_to(${VOLK} ${diligent_source_path}/DiligentCore/ThirdParty/VOLK)

# -- xxhash
vcpkg_download_distfile(XXHASH
    URLS "https://github.com/DiligentGraphics/xxHash/archive/30d6a3ee7cff0b9a25facf6cf5397ea1ab139b6f.zip"
    FILENAME "xxhash-30d6a3e.zip"
    SHA512 a2681c67f4b9d50e763f12cf471f16f81d479d721e5e37c5f71a163822866d3f8eae554853844fdbeef206de4bab802f26cc7b5d7e40befbd09c235b7cd63f79
)
diligent_extract_to(${XXHASH} ${diligent_source_path}/DiligentCore/ThirdParty/xxHash)

# --- diligent-fx
vcpkg_download_distfile(DILIGENT_FX
    URLS "https://github.com/daktronics/DiligentFX/archive/aa2c76bc689f8c9dd7430fbcbbe13a4d9543d051.zip"
    FILENAME "diligent_fx-aa2c76b.zip"
    SHA512 bf1f6ac3039fa3cdd1cabd14e5f718d3662226c6938acdafe34f322cec3851efb761ec6269a8eb23e8cdaab65e91c10e0f9c83a1bb175254c2ae3d543a73de51
)
diligent_extract_to(${DILIGENT_FX} ${diligent_source_path}/DiligentFX)

# --- diligent-samples
vcpkg_download_distfile(DILIGENT_SAMPLES
    URLS "https://github.com/daktronics/DiligentSamples/archive/5cb8c8e3f9e7fa417539297369ca00d3698c309a.zip"
    FILENAME "diligent_samples-5cb8c8e.zip"
    SHA512 53ff196a22480268fc1161f214c811d8e8f7596f2b1d2c56c73b5b646bc3a4a8adf04144b395c06652102d1f98470cddc0e86a3c614f14a360f7193eff0a5ccd
)
diligent_extract_to(${DILIGENT_SAMPLES} ${diligent_source_path}/DiligentSamples)

# --- diligent-tools
vcpkg_download_distfile(DILIGENT_TOOLS
    URLS "https://github.com/daktronics/DiligentTools/archive/2be32eb840d52b504eddca385a8022682215e483.zip"
    FILENAME "diligent_tools-2be32eb.zip"
    SHA512 4b6c33a53265f8df7b85fe7b95cb99f8b2a8c45ba647c207a9b6b2ec592c3c21ab6cdb374c0fb37615d30969c3a1f521a2ce763cb5bca288c31505e6e7dbcfa5
)
diligent_extract_with_patch_to(${DILIGENT_TOOLS} ${diligent_source_path}/DiligentTools "IMGUI-preprocessor-config.patch")

# -- args
vcpkg_download_distfile(ARGS
    URLS "https://github.com/DiligentGraphics/args/archive/156f89e977a8d9fd2f4b2881f0c067974c6c8317.zip"
    FILENAME "args-156f89e.zip"
    SHA512 5b85709701efec3dffa4503035c467d281c347c1337f0497210ead9bf9f1f1372aff54207ce433cccce1267c9d33a4e8daf04fd109cf5e6f188fe2fee7050a50
)
diligent_extract_to(${ARGS} ${diligent_source_path}/DiligentTools/ThirdParty/args)

# --- imgui
vcpkg_download_distfile(IMGUI
    URLS "https://github.com/DiligentGraphics/imgui/archive/66ad2ad5398cb61433009553e10fd326d13acb84.zip"
    FILENAME "imgui-66ad2ad.zip"
    SHA512 4102c4e4c58b6966171c9d693d2fac0487d393eea3668d13e6d55f23f1ff0845f3acf64708a6a30b777185ee92bc93c0f8c3c582c12b10cb8325436f7131079b
)
#diligent_extract_with_patch_to(${IMGUI} ${diligent_source_path}/DiligentTools/ThirdParty/imgui)
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
        #-DARCHIVER_SUPPORTED=1
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
diligent_move_to(${CURRENT_PACKAGES_DIR}/lib/cmake/glslang/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT})
diligent_move_to(${CURRENT_PACKAGES_DIR}/lib/cmake/xxHash/*cmake ${CURRENT_PACKAGES_DIR}/share/${PORT})
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
