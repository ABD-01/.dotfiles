# Target system
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# LLVM base path
set(LLVM_MINGW_BIN "D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/bin")

# Compilers
set(CMAKE_C_COMPILER   "${LLVM_MINGW_BIN}/clang.exe")
set(CMAKE_CXX_COMPILER "${LLVM_MINGW_BIN}/clang++.exe")


set(CMAKE_RC_COMPILER "${LLVM_MINGW_BIN}/llvm-windres.exe")

# LLVM binutils
set(CMAKE_AR      "${LLVM_MINGW_BIN}/llvm-ar.exe")
set(CMAKE_RANLIB  "${LLVM_MINGW_BIN}/llvm-ranlib.exe")
set(CMAKE_NM      "${LLVM_MINGW_BIN}/llvm-nm.exe")
set(CMAKE_OBJDUMP "${LLVM_MINGW_BIN}/llvm-objdump.exe")
set(CMAKE_STRIP   "${LLVM_MINGW_BIN}/llvm-strip.exe")

# Warnings
set(CMAKE_C_FLAGS_INIT   "-Wall -Wextra -Wpedantic")
set(CMAKE_CXX_FLAGS_INIT "-Wall -Wextra -Wpedantic")

# Ensure flags are not overridden by CMake
set(CMAKE_POLICY_DEFAULT_CMP0091 NEW)

#[[

$ clang -E -x c - -v < /dev/null
clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)
Target: x86_64-w64-windows-gnu
Thread model: posix
InstalledDir: D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/bin
 (in-process)
 "D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/bin/clang-16.exe" -cc1 -triple x86_64-w64-windows-gnu -E -disable-free -clear-ast-before-backend -disable-llvm-verifier -discard-value-names -main-file-name - -mrelocation-model pic -pic-level 2 -mframe-pointer=none -fmath-errno -ffp-contract=on -fno-rounding-math -mconstructor-aliases -mms-bitfields -funwind-tables=2 -target-cpu x86-64 -tune-cpu generic -debugger-tuning=gdb -v -fcoverage-compilation-dir=D:/PROJECTS/ATP/toolchains -resource-dir D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/lib/clang/16 -internal-isystem D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/lib/clang/16/include -internal-isystem D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/x86_64-w64-mingw32/include -internal-isystem D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/x86_64-w64-mingw32/usr/include -internal-isystem D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/include -fdebug-compilation-dir=D:/PROJECTS/ATP/toolchains -ferror-limit 19 -fmessage-length=158 -fno-use-cxa-atexit -fgnuc-version=4.2.1 -exception-model=seh -fcolor-diagnostics -faddrsig -o - -x c -
clang -cc1 version 16.0.6 based upon LLVM 16.0.6 default target x86_64-w64-mingw32
ignoring nonexistent directory "D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/x86_64-w64-mingw32/include"
ignoring nonexistent directory "D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/x86_64-w64-mingw32/usr/include"
#include "..." search starts here:
#include <...> search starts here:
 D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/lib/clang/16/include
 D:/PROJECTS/ATP/toolchains/default/llvm-mingw-20230614-msvcrt-x86_64/include
End of search list.
# 1 "<stdin>"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 388 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "<stdin>" 2

]]
