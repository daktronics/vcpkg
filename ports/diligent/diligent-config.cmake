include(CMakeFindDependencyMacro)

message(STATUS "CMAKE prefix path: ${CMAKE_PREFIX_PATH}")
message(STATUS "CMAKE current list path: ${CMAKE_CURRENT_LIST_DIR}")
message(STATUS "CMAKE module path: ${CMAKE_MODULE_PATH}")

include("${CMAKE_CURRENT_LIST_DIR}/SPIRV-ToolsConfig.cmake")
set(SPIRV-Tools_DIR "${CMAKE_CURRENT_LIST_DIR}")
include("${CMAKE_CURRENT_LIST_DIR}/SPIRV-Tools-optConfig.cmake")

#include("${CMAKE_CURRENT_LIST_DIR}/OSDependentTargets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/glslang-targets.cmake")
#include("${CMAKE_CURRENT_LIST_DIR}/OGLCompilerTargets.cmake")

#include("${CMAKE_CURRENT_LIST_DIR}/SPIRV-ToolsConfig.cmake")
#set(SPIRV-Tools_DIR "${CMAKE_CURRENT_LIST_DIR}")
#include("${CMAKE_CURRENT_LIST_DIR}/SPIRV-Tools-optTargets.cmake")
#set(SPIRV-Tools-opt_DIR "${CMAKE_CURRENT_LIST_DIR}")
#include("${CMAKE_CURRENT_LIST_DIR}/SPIRVTargets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/spirv_cross_core/spirv_cross_coreConfig.cmake")
#set(spirv_cross_core_DIR "${CMAKE_CURRENT_LIST_DIR}/spirv_cross_core")

include("${CMAKE_CURRENT_LIST_DIR}/Vulkan-Headers-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/xxHashConfig.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-PublicBuildSettings-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-BuildSettings-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-PrimitivesInterface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-Primitives-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-PlatformInterface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-BasicPlatform-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-Win32Platform-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-Common-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineInterface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-ArchiverInterface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsAccessories-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngine-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-HLSL2GLSLConverterLib-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-ShaderTools-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineD3DBaseInterface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineD3DBase-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineVkInterface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineD3D12Interface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineOpenGLInterface-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineD3D11Interface-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsTools-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineVk-shared-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineD3D12-shared-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineOpenGL-shared-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-GraphicsEngineD3D11-shared-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-JSON-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-TextureLoader-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-AssetLoader-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Diligent-Imgui-target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Diligent-NativeAppBase-target.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/DiligentFX-target.cmake")