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
                ${ARGN}
    )
    file(RENAME ${source_path} ${destination_path})
endfunction()

# --- diligent-core
vcpkg_download_distfile(DILIGENT_CORE
    URLS "https://github.com/daktronics/DiligentCore/archive/d201544b4d972edff0ecd70d3797cfb058d9c50b.zip"
    FILENAME "diligent_core-d201544.zip"
    SHA512 349f60b949ef66f7b4a1d664789c6017ff75f61879185dd2fc644fbc89682a426f468c4b944a83d08a17ada1970d56767bf145ffbf8f441616da55a3d7a519e9
)
diligent_extract_to(${DILIGENT_CORE} ${diligent_source_path}/DiligentCore)

# --- glslang
vcpkg_download_distfile(GLSLANG
    URLS "https://github.com/daktronics/glslang/archive/54726b3c1c5cb70043174365750ab0f1b7e1a6a0.zip"
    FILENAME "glslang-54726b3.zip"
    SHA512 9aef33bcfc4a9ffdeacca31d9059303f22aaf738996ca51d5be372a7ec9f413f9202ecfa9efdc665fa8289b9f14ce8046ce726b0a051bb28c1c7d1114e92e060
)
diligent_extract_to(${GLSLANG} ${diligent_source_path}/DiligentCore/ThirdParty/glslang)

# --- googletest
vcpkg_download_distfile(GOOGLETEST
    URLS "https://github.com/DiligentGraphics/googletest/archive/c875c4e2249ec124c24f72141b3780c22256fd44.zip"
    FILENAME "googletest-c875c4e.zip"
    SHA512 b80f388773ff5d85ac3719f9dc174b36fbd59fa1d43c8552c2c863478e7ab6d337ef2eb86767f5cce3d6cbda1b5d9813a07d73e211b835561c9aa6e69d9c056e
)
diligent_extract_to(${GOOGLETEST} ${diligent_source_path}/DiligentCore/ThirdParty/googletest)

# --- spirv-cross
vcpkg_download_distfile(SPIRV_CROSS
    URLS "https://github.com/DiligentGraphics/SPIRV-Cross/archive/bccaa94db814af33d8ef05c153e7c34d8bd4d685.zip"
    FILENAME "SPIRV_Cross-bccaa94-1.zip"
    SHA512 541af25ad3cd11f5998462af54c7c1541670f37cefb5be7fe1398f8ea92c5970b8d39cf9eac80a714d7f2f5599d9b35eb516486c7f1724555a8b5c4a679e083c
)
diligent_extract_to(${SPIRV_CROSS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Cross)

# --- spirv headers
vcpkg_download_distfile(SPIRV_HEADERS
    URLS "https://github.com/DiligentGraphics/SPIRV-Headers/archive/ae89923fa781650569ca15e5b498a9e4e46ee9c9.zip"
    FILENAME "SPIRV_Headers-ae89923.zip"
    SHA512 77d5827f94f2c82e8bdd995d34f0270595312fa4874f7740f749f78947e8fb7aa3da23518a17e5755c78867f518b6e94048e16dbf2871715532e0fa63bcede65
)
diligent_extract_to(${SPIRV_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Headers)

# --- spirv tools
vcpkg_download_distfile(SPIRV_TOOLS
    URLS "https://github.com/DiligentGraphics/SPIRV-Tools/archive/e68fe9be4e6ca63097ac4305d7552ad29afd5004.zip"
    FILENAME "SPIRV_Tools-e68fe9b.zip"
    SHA512 f0910b375a6725f61f5db9427f58d627bcf27f087d8e6fb5b2cc3f3766ec688fb72bb5035df89c12ae9282ba8f68a3b6d9a533ea2d07b49825473eda27dab2c3
)
diligent_extract_with_patch_to(${SPIRV_TOOLS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Tools "SPIRV-Tools-path-length.patch")
#diligent_extract_to(${SPIRV_TOOLS} ${diligent_source_path}/DiligentCore/ThirdParty/SPIRV-Tools)

# --- vulkan headers
vcpkg_download_distfile(VULKAN_HEADERS
    URLS "https://github.com/DiligentGraphics/Vulkan-Headers/archive/a3b683653e6a498514ef8a1865594810e91c594c.zip"
    FILENAME "Vulkan_Headers-a3b6836.zip"
    SHA512 058859ff422be8594af8c07fcb52c76cd8614d48e0667790138f22be2d20d0ba70c1bf5ae52d2f7dc923663241a87f21de07ed007d72d97e74bf5315726ef57e
)
diligent_extract_to(${VULKAN_HEADERS} ${diligent_source_path}/DiligentCore/ThirdParty/Vulkan-Headers)

# --- volk
vcpkg_download_distfile(VOLK
    URLS "https://github.com/DiligentGraphics/volk/archive/d1f44cc7f14c991e7cce613a361ff5495bbc6342.zip"
    FILENAME "volk-d1f44cc.zip"
    SHA512 c81f2b1171110d3de8339da9b32145544f8d9855501143d005f2324a8502df5558510b7bc5f0d5ab432aab75fd92bb2cbb3db02d5d5840488be302d089fbae01
)
diligent_extract_to(${VOLK} ${diligent_source_path}/DiligentCore/ThirdParty/VOLK)

# -- xxhash
vcpkg_download_distfile(XXHASH
    URLS "https://github.com/DiligentGraphics/xxHash/archive/5cb575c405a394d634d567566966a535e99645a6.zip"
    FILENAME "xxhash-5cb575c.zip"
    SHA512 204175adab0f8713b0350606730e0fd139fec4d8fed9783cac1dbf50abc1c48f18d73ebb2f345bbc7fddb7cafa60f591d94a2b2245069a27a6cc17da0b1fd74f
)
diligent_extract_to(${XXHASH} ${diligent_source_path}/DiligentCore/ThirdParty/xxHash)

# --- diligent-fx
vcpkg_download_distfile(DILIGENT_FX
    URLS "https://github.com/daktronics/DiligentFX/archive/2f40b2eb4feec61a65cfcc5f534dd0a2604a4108.zip"
    FILENAME "diligent_fx-2f40b2e.zip"
    SHA512 0259ff259ab6c86f65b676e27cfa835737a90dbb9da48888e06d00020efe8c1cdadcf8d7463f9e6c3e9a647aad0dfa5c42f814df6f7501669f655dd7a90f6f09
)
diligent_extract_to(${DILIGENT_FX} ${diligent_source_path}/DiligentFX)

# --- diligent-samples
vcpkg_download_distfile(DILIGENT_SAMPLES
    URLS "https://github.com/daktronics/DiligentSamples/archive/fd1139b4f601c6f7d2c45dbed0d87d00a727c61f.zip"
    FILENAME "diligent_samples-fd1139b.zip"
    SHA512 8ebf7d292cba42df0756ef79865192e9db41679cb299bd533935d469e4bbe11b36cca304219408288c6cf96adf46f5eaab146166fd4e5640c35f5de69795d211
)
diligent_extract_to(${DILIGENT_SAMPLES} ${diligent_source_path}/DiligentSamples)

# --- diligent-tools
vcpkg_download_distfile(DILIGENT_TOOLS
    URLS "https://github.com/daktronics/DiligentTools/archive/41aed1f827a2fc7d24c5e4df0e37ed33720a517d.zip"
    FILENAME "diligent_tools-41aed1f.zip"
    SHA512 1f006c3601e5b3fd53dd261d4c206e7f712cdb8795fda3eb104d407eaf03904705b6de657972201b0b0c1f3bed81bfd3e2293577ca58cf62e4b11529ed06d2d4
)
diligent_extract_with_patch_to(${DILIGENT_TOOLS} ${diligent_source_path}/DiligentTools "IMGUI-preprocessor-config.patch" "imgui-renderer.patch")

# -- args
vcpkg_download_distfile(ARGS
    URLS "https://github.com/DiligentGraphics/args/archive/b7d67237e8bdaa517d7fd6e4e84e1f6efa24f8c5.zip"
    FILENAME "args-b7d6723.zip"
    SHA512 e821b402a653b8fe6abf4a760567f177c14ba26e5177a618ce19b86ffac5aeeb6604a0a8bb08406096bd553d41f278979f82c31d925a5a8b58544b07ba8312ed
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
