# Target system
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# LLVM base path
set(LLVM_BIN "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC/Tools/Llvm/x64/bin")

# Compilers
set(CMAKE_C_COMPILER   "${LLVM_BIN}/clang.exe")
set(CMAKE_CXX_COMPILER "${LLVM_BIN}/clang++.exe")

# RC compiler (MSVC Windows SDK)
set(WINDOWS_SDK_DIR "C:/Program Files (x86)/Windows Kits/10")
set(WINDOWS_SDK_VERSION 10.0.20348.0)
set(CMAKE_RC_COMPILER "${WINDOWS_SDK_DIR}/bin/${WINDOWS_SDK_VERSION}/x64/rc.exe")

# Binutils (LLVM)
set(CMAKE_AR        "${LLVM_BIN}/llvm-ar.exe")
set(CMAKE_RANLIB    "${LLVM_BIN}/llvm-ranlib.exe")
set(CMAKE_OBJDUMP   "${LLVM_BIN}/llvm-objdump.exe")
set(CMAKE_OBJCOPY   "${LLVM_BIN}/llvm-objcopy.exe")
set(CMAKE_NM        "${LLVM_BIN}/llvm-nm.exe")
set(CMAKE_STRIP     "${LLVM_BIN}/llvm-strip.exe")

# Warnings
set(CMAKE_C_FLAGS_INIT   "-Wall -Wextra -Wpedantic")
set(CMAKE_CXX_FLAGS_INIT "-Wall -Wextra -Wpedantic")

# Ensure flags are not overridden by CMake
set(CMAKE_POLICY_DEFAULT_CMP0091 NEW)



#[[

$ clang -E -x c - -v < /dev/null
clang version 19.1.5
Target: x86_64-pc-windows-msvc
Thread model: posix
InstalledDir: C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\Llvm\x64\bin
 (in-process)
 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Tools\\Llvm\\x64\\bin\\clang.exe" -cc1 -triple x86_64-pc-windows-msvc19.44.35211 -E
-disable-free -clear-ast-before-backend -disable-llvm-verifier -discard-value-names -main-file-name - -mrelocation-model pic -pic-level 2 -mframe-pointer=none -relaxed-aliasing -fmath-errno -ffp-contract=on -fno-rounding-math -mconstructor-aliases -funwind-tables=2 -target-cpu x86-64 -tune-cpu generic "-fdebug-compilation-dir=D:\\PROJECTS\\ATP\\toolchains" -v "-fcoverage-compilation-dir=D:\\PROJECTS\\ATP\\toolchains" -resource-dir "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Tools\\Llvm\\x64\\lib\\clang\\19" -internal-isystem "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Tools\\Llvm\\x64\\lib\\clang\\19\\include" -internal-isystem "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Tools\\MSVC\\14.44.35207\\include" -internal-isystem "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Auxiliary\\VS\\include" -internal-isystem "C:\\Program
Files (x86)\\Windows Kits\\10\\include\\10.0.20348.0\\ucrt" -internal-isystem "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.20348.0\\um" -internal-isystem "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.20348.0\\shared" -ferror-limit 19 -fmessage-length=158 -fno-use-cxa-atexit -fms-extensions
-fms-compatibility -fms-compatibility-version=19.44.35211 -fskip-odr-check-in-gmf -fdelayed-template-parsing -fcolor-diagnostics -faddrsig -o - -x c -
clang -cc1 version 19.1.5 based upon LLVM 19.1.5 default target x86_64-pc-windows-msvc
#include "..." search starts here:
#include <...> search starts here:
 C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\Llvm\x64\lib\clang\19\include
 C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\14.44.35207\include
 C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\VS\include
 C:\Program Files (x86)\Windows Kits\10\include\10.0.20348.0\ucrt
 C:\Program Files (x86)\Windows Kits\10\include\10.0.20348.0\um
 C:\Program Files (x86)\Windows Kits\10\include\10.0.20348.0\shared
End of search list.
# 1 "<stdin>"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 385 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "<stdin>" 2

]]
