cmake_minimum_required (VERSION 3.18.6)
project(hello)

################################
# general config
################################

message("-- use c compiler ${CMAKE_C_COMPILER}")
message("-- use c++ compiler ${CMAKE_CXX_COMPILER}")

# set compile parameter
if (NOT CMAKE_CROSSCOMPILING)
	if (${CMAKE_C_COMPILER_ID} STREQUAL GNU)
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
	elseif (${CMAKE_C_COMPILER_ID} MATCHES Clang)
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
	elseif (${CMAKE_C_COMPILER_ID} STREQUAL MSVC)
		add_definitions(-D_CRT_SECURE_NO_WARNINGS=1 -D_UNICODE -DUNICODE)
		add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
		add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")

		if (MSVC_VERSION GREATER_EQUAL 1920)
			message("MSVC version >= VS 16.0 (v142 toolset)")

			# see: https://learn.microsoft.com/en-us/cpp/build/reference/zc-cplusplus?view=msvc-170
			# The /Zc:__cplusplus compiler option enables updated __cplusplus macro
			add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/Zc:__cplusplus>")
			add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/std:c++20>")
		endif()
	endif()
else()
	if (ANDROID)
		message("-- cmake run cross compiling, building for android")
	else()
		message(FATAL_ERROR "-- building for unsupport platform")
	endif()
endif()

message("-- c compiler support features: ")
foreach(feature ${CMAKE_C_COMPILE_FEATURES})
	message("support feature: ${feature}")
endforeach()

# set output directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# for LSP
if (NOT ${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
	set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

# set use folder in vs
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

################################
# output options
################################
message("--------------------------------")
message("# c compiler flags: ${CMAKE_C_FLAGS}")
message("# cxx compiler flags: ${CMAKE_CXX_FLAGS}")
message("# CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message("# BUILD_SHARED_LIBS: ${BUILD_SHARED_LIBS}")
message("--------------------------------")

add_executable(hello ${CMAKE_CURRENT_LIST_DIR}/src/main.c)
install(TARGETS hello
	RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
	ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
	LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}")
