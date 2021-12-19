cmake_minimum_required (VERSION 3.0.2)
project(clang_format_view)

# print compiler
message("-- use c compiler ${CMAKE_C_COMPILER}")
message("-- use c++ compiler ${CMAKE_CXX_COMPILER}")

# set compile parameter
if (${CMAKE_CXX_COMPILER_ID} STREQUAL GNU)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native -Wall -Wextra")
elseif (${CMAKE_CXX_COMPILER_ID} MATCHES Clang)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native -Wall -Wextra -Wno-missing-field-initializers")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS=1 -D_UNICODE -DUNICODE)
endif()

# set standard and print features
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

message("-- c compiler support features: ")
foreach(feature ${CMAKE_C_COMPILE_FEATURES})
	message("support feature: ${feature}")
endforeach()

# for vim plugin - YCM
if (NOT ${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
	set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

# set output directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

################################
# mugglec

include(FetchContent)
set(FETCHCONTENT_BASE_DIR ${CMAKE_BINARY_DIR}/_deps)

FetchContent_Declare(
        mugglec
        GIT_REPOSITORY https://github.com/MuggleWei/mugglec.git
        GIT_TAG v0.0.1
)
FetchContent_MakeAvailable(mugglec)

# set mugglec compile options
set(MUGGLE_BUILD_TRACE OFF CACHE BOOL "")
set(MUGGLE_BUILD_SHARED_LIB ON CACHE BOOL "")
set(MUGGLE_BUILD_STATIC_PIC ON CACHE BOOL "")
set(MUGGLE_BUILD_BENCHMARK OFF CACHE BOOL "")
set(MUGGLE_BUILD_TESTING OFF CACHE BOOL "")
set(MUGGLE_BUILD_EXAMPLE OFF CACHE BOOL "")

################################
# project

set(mugglec mugglec)
include(${CMAKE_BINARY_DIR}/_deps/mugglec-src/cmake/muggle_utils.cmake)

function(add_example name folder)
	message("add example ${name} ${folder}")
	
	set(name example_${name})

	file(GLOB tmp_h ${folder}/*.h)
	file(GLOB tmp_c ${folder}/*.c)
	file(GLOB tmp_cpp ${folder}/*.cpp)
	file(GLOB tmp_cc ${folder}/*.cc)

	if (WIN32)
		add_executable(${name} ${tmp_h} ${tmp_c} ${tmp_cpp} ${tmp_cc})
		set_target_properties(${name}
			PROPERTIES
			FOLDER "example"
			VS_DEBUGGER_WORKING_DIRECTORY "$(OutDir)"
		)
	else()
		add_executable(${name} ${tmp_c} ${tmp_cpp} ${tmp_cc})
	endif(WIN32)
	add_dependencies(${name} ${mugglec})
	target_link_libraries(${name} ${mugglec})
	target_include_directories(${name} PUBLIC
		${CMAKE_BINARY_DIR}/_deps/mugglec-src
	)
endfunction()

message("---------------------- example ----------------------")
SUBDIRLIST(example_dirs ${CMAKE_CURRENT_LIST_DIR}/example)
FOREACH(subdir ${example_dirs})
	add_example(${subdir} ${CMAKE_CURRENT_LIST_DIR}/example/${subdir})
ENDFOREACH()
