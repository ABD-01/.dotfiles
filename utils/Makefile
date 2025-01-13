CC := gcc
CPP := g++
CFLAGS := -g -Wall -std=c99 
CPPFLAGS := -g -Wall -std=c++11 
# -std=c++11 -fsanitize=undefined -Wpedantic -Wall  -Wextra -Wconversion -Werror
SRC_DIR := .
OUTPUT_DIR := build

# List all C files in the source directory
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
SRC_FILES_CPP := $(wildcard $(SRC_DIR)/*.cpp)

# Derive the names of the executables from the source filenames (without extensions)
EXECUTABLES := $(patsubst $(SRC_DIR)/%.c,$(OUTPUT_DIR)/%,$(SRC_FILES))
EXECUTABLES_CPP := $(patsubst $(SRC_DIR)/%.cpp,$(OUTPUT_DIR)/%,$(SRC_FILES_CPP))

.PHONY: all clean

all: $(EXECUTABLES) $(EXECUTABLES_CPP)


# Rule for .c files
$(OUTPUT_DIR)/%: $(SRC_DIR)/%.c
	@mkdir -p $(OUTPUT_DIR)
	$(CC) $(CFLAGS) $< -o $@

# Rule for .cpp files
$(OUTPUT_DIR)/%: $(SRC_DIR)/%.cpp
	@mkdir -p $(OUTPUT_DIR)
	$(CPP) $(CPPFLAGS) $< -o $@

clean:
	rm -f $(EXECUTABLES) $(EXECUTABLES_CPP)
	rm -rf $(OUTPUT_DIR)
