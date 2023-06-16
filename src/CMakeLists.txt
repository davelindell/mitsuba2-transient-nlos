if (MTS_ENABLE_PYTHON)
  # Python bindings (need to include it first so that some required CMake
  # functions are defined).
  include("cmake/libpython.cmake")
endif()

# Mitsuba support libraries
add_subdirectory(libcore)
add_subdirectory(librender)
if (MTS_ENABLE_GUI)
    add_subdirectory(libui)
endif()

# Mitsuba executables
add_subdirectory(mitsuba)

if (MTS_ENABLE_GUI)
    add_subdirectory(mtsgui)
endif()

set (source_dir "${CMAKE_CURRENT_SOURCE_DIR}/../ext/libtorch")
set(LIBTORCH_PATH ${source_dir})
set(Torch_DIR "${source_dir}/share/cmake/Torch")

list(APPEND CMAKE_PREFIX_PATH ${LIBTORCH_PATH})
find_package(Torch REQUIRED)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${TORCH_CXX_FLAGS}")
include_directories(${TORCH_INCLUDE_DIRS})

# The following code block is suggested to be used on Windows.
# According to https://github.com/pytorch/pytorch/issues/25457,
# the DLLs need to be copied to avoid memory errors.
if (MSVC)
  file(GLOB TORCH_DLLS "${TORCH_INSTALL_PREFIX}/lib/*.dll")
  add_custom_command(TARGET streakhdr
                     POST_BUILD
                     COMMAND ${CMAKE_COMMAND} -E copy_if_different
                     ${TORCH_DLLS}
                     $<TARGET_FILE_DIR:streakhdr>)
endif (MSVC)

# # Plugins
add_subdirectory(bsdfs)
add_subdirectory(emitters)
add_subdirectory(films)
add_subdirectory(integrators)
add_subdirectory(media)
add_subdirectory(phase)
add_subdirectory(rfilters)
add_subdirectory(samplers)
add_subdirectory(sensors)
add_subdirectory(shapes)
add_subdirectory(spectra)
add_subdirectory(textures)

if (MTS_ENABLE_PYTHON)
  add_subdirectory(python)

  # Test support
  include("cmake/tests.cmake")
endif()
