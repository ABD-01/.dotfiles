# cmake/mips-toolchain.cmake
#
# Copyright (c) 2025 Accolade Electronics Pvt. Ltd.
# 
# Date:     April 4, 2025
# Author:   Muhammed Abdullah Shaikh <muhammed.shaikh@accoladeelectronics.com>
# 
# Brief:    This file holds MIPS GCC toolchain SETtings, paths, etc.
#           SETs various compiler flags as per BUILD_TYPE
#           Also SETs architechture specific CPU and FPU flags.

# System type
SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_PROCESSOR MIPS)

# TOOLCHAIN EXTENSION
IF(WIN32)
    SET(TOOLCHAIN_EXT ".exe")
ELSE()
    SET(TOOLCHAIN_EXT "")
ENDIF()

set(GCC_VERSION "4.4.2")

find_program(MIPS_GCC_PATH "mips-elf-gcc")
if (NOT MIPS_GCC_PATH)
  message(FATAL_ERROR "Cannot find MIPS GCC compiler: mips-elf-gcc")
endif()
get_filename_component(TOOLCHAIN_BIN_DIR ${MIPS_GCC_PATH} DIRECTORY) # Gets C:/CSDTK4/mips-elf-4.4.2/bin
get_filename_component(MIPS_TOOLCHAIN_PATH ${TOOLCHAIN_BIN_DIR} DIRECTORY) # Gets C:/CSDTK4/mips-elf-4.4.2
message(STATUS "MIPS_TOOLCHAIN_PATH: ${MIPS_TOOLCHAIN_PATH}")

# # Find the MIPS compiler directory from environment variable or use default
# IF(DEFINED ENV{MIPSGCC_DIR})
#     SET(MIPS_TOOLCHAIN_PATH $ENV{MIPSGCC_DIR})
# ELSE()
#     SET(MIPS_TOOLCHAIN_PATH "C:/CSDTK4/mips-elf-4.4.2")
#     message(STATUS "MIPSGCC_DIR environment variable not SET. Using default: ${MIPS_TOOLCHAIN_PATH}")
# ENDIF()
# # Ensure the path has consistent forward slashes
# STRING(REGEX REPLACE "\\\\" "/" MIPS_TOOLCHAIN_PATH "${MIPS_TOOLCHAIN_PATH}")

# SET the compilers
set(CMAKE_C_COMPILER ${MIPS_TOOLCHAIN_PATH}/bin/mips-elf-gcc${TOOLCHAIN_EXT} CACHE STRING "mips-elf-gcc")
set(CMAKE_CXX_COMPILER ${MIPS_TOOLCHAIN_PATH}/bin/mips-elf-g++${TOOLCHAIN_EXT} CACHE STRING "mips-elf-g++")
set(CMAKE_ASM_COMPILER ${MIPS_TOOLCHAIN_PATH}/bin/mips-elf-as${TOOLCHAIN_EXT} CACHE STRING "mips-elf-as")
set(CMAKE_LINKER ${MIPS_TOOLCHAIN_PATH}/bin/mips-elf-ld${TOOLCHAIN_EXT} CACHE STRING "mips-elf-ld")
set(CMAKE_OBJCOPY ${MIPS_TOOLCHAIN_PATH}/bin/mips-elf-objcopy${TOOLCHAIN_EXT} CACHE STRING "mips-elf-objcopy")
set(CMAKE_SIZE ${MIPS_TOOLCHAIN_PATH}/bin/mips-elf-size${TOOLCHAIN_EXT} CACHE STRING "mips-elf-size")

# Avoid compiler checks for cross-compiling
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_FIND_ROOT_PATH 
    "${MIPS_TOOLCHAIN_PATH}/mips-elf/sys-include"
    "${MIPS_TOOLCHAIN_PATH}/lib/gcc/mips-elf/${GCC_VERSION}/include"
)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(LIB_INC "${MIPS_TOOLCHAIN_PATH}/lib/gcc/mips-elf/${GCC_VERSION}/include" CACHE PATH "Compiler include path")
set(ENV_INC "${MIPS_TOOLCHAIN_PATH}/mips-elf/sys-include" CACHE PATH "System include path")
set(ENV_LIB_GCC "${MIPS_TOOLCHAIN_PATH}/lib/gcc/mips-elf/${GCC_VERSION}" CACHE PATH "GCC library path")


set(MIPS_CPU_FLAGS
    -mips16
    -march=xcpu
    -mtune=xcpu
    -EL
    -msoft-float
    -nostdlib
    -nostdinc
    -nodefaultlibs
    -Wa,-march=xcpu,-mtune=xcpu
)
string(REPLACE ";" " " MIPS_CPU_FLAGS "${MIPS_CPU_FLAGS}")

set(CMAKE_C_FLAGS_INIT "-I\"${ENV_INC}\" -I\"${LIB_INC}\" ${MIPS_CPU_FLAGS}")
set(CMAKE_CXX_FLAGS_INIT "-I\"${ENV_INC}\" -I\"${LIB_INC}\" ${MIPS_CPU_FLAGS}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS_INIT}" CACHE STRING "C compiler flags" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS_INIT}" CACHE STRING "C++ compiler flags" FORCE)
set(CMAKE_ASM_FLAGS "-march=xcpu -mtune=xcpu -EL" CACHE STRING "ASM compiler flags" FORCE)

set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")