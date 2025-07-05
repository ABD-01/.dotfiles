#!/bin/bash

# === Setup Variables ===
VS_BASE="/c/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools"
MSVC_VER="14.44.35207"
SDK_VER="10.0.20348.0"

# === Toolchain Binaries ===
MSVC_BIN="$VS_BASE/VC/Tools/MSVC/$MSVC_VER/bin/HostX86/x86"
MSVC_LLVM="$VS_BASE/VC/Tools/Llvm/bin"
MSBUILD_BIN="$VS_BASE/MSBuild/Current/Bin"
COMMON_TOOLS="$VS_BASE/Common7/Tools"
SDK_BIN="/c/Program Files (x86)/Windows Kits/10/bin/$SDK_VER/x86"

# === INCLUDE Paths ===
INCLUDE_PATHS="\
$VS_BASE/VC/Tools/MSVC/$MSVC_VER/include;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/ucrt;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/um;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/shared;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/winrt;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/cppwinrt"

# === LIB Paths ===
LIB_PATHS="\
$VS_BASE/VC/Tools/MSVC/$MSVC_VER/lib/x86;\
/c/Program Files (x86)/Windows Kits/10/lib/$SDK_VER/ucrt/x86;\
/c/Program Files (x86)/Windows Kits/10/lib/$SDK_VER/um/x86"

# === LIBPATH ===
LIBPATH_PATHS="\
$VS_BASE/VC/Tools/MSVC/$MSVC_VER/lib/x86;\
/c/Program Files (x86)/Windows Kits/10/UnionMetadata/$SDK_VER;\
/c/Program Files (x86)/Windows Kits/10/References/$SDK_VER;\
/c/Windows/Microsoft.NET/Framework/v4.0.30319"

# === Export Environment ===
export PATH="$MSVC_BIN:$SDK_BIN:$MSBUILD_BIN:$COMMON_TOOLS:$MSVC_LLVM:$PATH"
export INCLUDE="$(echo $INCLUDE_PATHS | sed 's/;/:/g')"
export LIB="$(echo $LIB_PATHS | sed 's/;/:/g')"
export LIBPATH="$(echo $LIBPATH_PATHS | sed 's/;/:/g')"

# === Compiler ===
export CC=clang
export CXX=clang++

