# Cross compile toolchain for telit.
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_CROSSCOMPILING 1)

# TOOLCHAIN EXTENSION
IF(WIN32)
    SET(TOOLCHAIN_EXT ".exe")
ELSE()
    SET(TOOLCHAIN_EXT "")
ENDIF()

set(GCC_VERSION "12.3.1")

# Path to toolchain binaries.
if(NOT DEFINED ENV{AZ_SDK_TOOLCHAIN})
    message(FATAL_ERROR "AZ_SDK_TOOLCHAIN not set")
endif()

if(NOT DEFINED ENV{AZ_SDK_SYSROOT})
    message(FATAL_ERROR "AZ_SDK_SYSROOT not set")
endif()

set(TOOLCHAIN_ROOT $ENV{AZ_SDK_TOOLCHAIN})
set(SYSROOT        $ENV{AZ_SDK_SYSROOT})

# TARGET_TRIPLET
set(TARGET_PREFIX arm-oe-linux-gnueabi-)

# Absolute compiler & tools.
SET(CMAKE_C_COMPILER     "${TARGET_PREFIX}gcc")
SET(CMAKE_CXX_COMPILER   "${TARGET_PREFIX}g++")
SET(CMAKE_ASM_COMPILER   "${TARGET_PREFIX}as")
SET(CMAKE_AR             "${TARGET_PREFIX}ar")
SET(CMAKE_RANLIB         "${TARGET_PREFIX}ranlib")
SET(CMAKE_STRIP          "${TARGET_PREFIX}strip")
SET(CMAKE_NM             "${TARGET_PREFIX}nm")
SET(CMAKE_SIZE           "${TARGET_PREFIX}size")
SET(CMAKE_OBJCOPY        "${TARGET_PREFIX}objcopy")
SET(CMAKE_OBJDUMP        "${TARGET_PREFIX}objdump")
SET(CMAKE_LINKER         "${TARGET_PREFIX}ld")
SET(CMAKE_GDB            "${TARGET_PREFIX}gdb")

# Prevent try_compile from creating executables during configure.
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Platform specific compile flags.
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

SET(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS_INIT} -march=armv7-a -mfloat-abi=softfp -mfpu=neon --sysroot=${CMAKE_SYSROOT}")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS_INIT} -march=armv7-a -mfloat-abi=softfp -mfpu=neon --sysroot=${CMAKE_SYSROOT}")
