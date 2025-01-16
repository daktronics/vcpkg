include(${CMAKE_CURRENT_LIST_DIR}/SPIRV-ToolsTarget.cmake)
set(SPIRV-Tools_LIBRARIES SPIRV-Tools-static)
get_target_property(SPIRV-Tools_INCLUDE_DIRS SPIRV-Tools-static INTERFACE_INCLUDE_DIRECTORIES)
