set(MTS_PLUGIN_PREFIX "films")

add_plugin(hdrfilm  hdrfilm.cpp)
add_plugin(streakhdrfilm  streakhdrfilm.cpp)
target_link_libraries(streakhdrfilm PRIVATE "${TORCH_LIBRARIES}")

# Register the test directory
add_tests(${CMAKE_CURRENT_SOURCE_DIR}/tests)
