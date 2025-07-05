#!/bin/bash

# === Setup Variables ===
VS_BASE="/c/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools"
MSVC_VER="14.44.35207"
SDK_VER="10.0.20348.0"

MSVC_BIN="$VS_BASE/VC/Tools/MSVC/$MSVC_VER/bin/HostX64/x64"
MSVC_LLVM="$VS_BASE/VC/Tools/Llvm/x64/bin"
MSBUILD_BIN="$VS_BASE/MSBuild/Current/Bin/amd64"
COMMON_TOOLS="$VS_BASE/Common7/Tools"
SDK_BIN="/c/Program Files (x86)/Windows Kits/10/bin/$SDK_VER/x64"

INCLUDE_PATHS="\
$VS_BASE/VC/Tools/MSVC/$MSVC_VER/include;\
$VS_BASE/VC/Auxiliary/VS/include;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/ucrt;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/um;\
/c/Program Files (x86)/Windows Kits/10/include/$SDK_VER/shared"

LIB_PATHS="\
$VS_BASE/VC/Tools/MSVC/$MSVC_VER/lib/x64;\
/c/Program Files (x86)/Windows Kits/10/lib/$SDK_VER/ucrt/x64;\
/c/Program Files (x86)/Windows Kits/10/lib/$SDK_VER/um/x64"

LIBPATH_PATHS="\
$VS_BASE/VC/Tools/MSVC/$MSVC_VER/lib/x64"

# === Export Paths ===
export PATH="$MSVC_BIN:$SDK_BIN:$MSBUILD_BIN:$COMMON_TOOLS:$MSVC_LLVM:$PATH"
export INCLUDE="$(echo $INCLUDE_PATHS | sed 's/;/:/g')"
export LIB="$(echo $LIB_PATHS | sed 's/;/:/g')"
export LIBPATH="$(echo $LIBPATH_PATHS | sed 's/;/:/g')"

# === Compiler ===
export CC=clang
export CXX=clang++

