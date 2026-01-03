# Generic CMake Makefile
# Usage: make BUILD_DIR=/d/PROJECTS/compiler-shenannigans/SDL2-2.30.5/build-msvc \
#	 SRC_DIR=/d/PROJECTS/compiler-shenannigans/SDL2-2.30.5  \
#	 CMAKE_TOOLCHAIN_FILE=/d/PROJECTS/ATP/toolchains/clang-msvc/clang_x86_64_msvc_toolchain.cmake
# Defaults (can be overridden on command line)

BUILD_DIR ?= .
SRC_DIR   ?= ..
CMAKE_TOOLCHAIN_FILE ?=

CONFIG_STAMP := $(BUILD_DIR)/.cmake_configured

.PHONY: all configure build install clean

all: build

configure: $(CONFIG_STAMP)

$(CONFIG_STAMP):
	@echo "--- Configuring project with CMake ---"
	@mkdir -p $(BUILD_DIR)
	cmake -S $(SRC_DIR) -B $(BUILD_DIR) \
		-G "MinGW Makefiles" \
		$(if $(CMAKE_TOOLCHAIN_FILE),-DCMAKE_TOOLCHAIN_FILE=$(CMAKE_TOOLCHAIN_FILE)) \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
		-DCMAKE_INSTALL_PREFIX=$(BUILD_DIR)/install
	@touch $(CONFIG_STAMP)

build: $(CONFIG_STAMP)
	@echo "--- Building project using generated Makefiles ---"
	cmake --build $(BUILD_DIR) --parallel 4 -- --no-print-directory

install: build
	@echo "--- Installing into $(BUILD_DIR)/install ---"
	cmake --build $(BUILD_DIR) --target install -- --no-print-directory

clean:
	@echo "--- Cleaning build directory ---"
	rm -rf $(BUILD_DIR)
