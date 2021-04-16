cmake_minimum_required (VERSION 3.0.2)
project(pyfoo)

# set compile parameter
if (${CMAKE_CXX_COMPILER_ID} STREQUAL GNU)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native -Wall -Wextra -std=c++11")
elseif (${CMAKE_CXX_COMPILER_ID} MATCHES Clang)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native -Wall -Wextra -Wno-missing-field-initializers")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS=1 -D_UNICODE -DUNICODE)
endif()

# for vim plugin - YCM
if (NOT ${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
	set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

# set output directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# cmake
include(${CMAKE_CURRENT_LIST_DIR}/../cmake/muggle_utils.cmake)

# set use folder in vs
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# find python libs
find_package(PythonLibs)
if (PYTHONLIBS_FOUND)
	message("find python header " ${PYTHON_INCLUDE_DIRS})
	message("find python libs " ${PYTHON_LIBRARIES})
else()
	message(FATAL_ERROR "failed find python libs")
endif()

# include & link
include_directories(
	${CMAKE_CURRENT_LIST_DIR}/src/
	${PYTHON_INCLUDE_DIRS}
	${CMAKE_CURRENT_LIST_DIR}/build/foo/include
	${CMAKE_CURRENT_LIST_DIR}/build/pyfoo
)
link_directories(
	${CMAKE_CURRENT_LIST_DIR}/build/foo/lib
)

# add pyfoo
set(pyfoo pyfoo)
muggle_add_project(${pyfoo} ${CMAKE_CURRENT_LIST_DIR}/build/pyfoo SHARED)
target_link_libraries(${pyfoo}
	PUBLIC foo ${PYTHON_LIBRARIES}
)
