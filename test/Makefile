ROOT_DIR := ..
BUILD_DIR := $(ROOT_DIR)/build/tests
BIN_DIR := $(ROOT_DIR)/bin/tests
EMU_DIR := $(BUILD_DIR)/emulator
OBJ_DIR := $(BUILD_DIR)/obj
INCLUDE_DIRS := $(ROOT_DIR)/include $(ROOT_DIR)/src $(CURDIR)/include

SDCC_BIN ?= $(if $(wildcard /opt/sdcc/bin/sdcc),/opt/sdcc/bin,/usr/bin)
CC := $(SDCC_BIN)/sdcc
MAKEBIN := $(SDCC_BIN)/makebin
CPMCP := cpmcp

CFLAGS := --std-c11 -mz80 --sdcccall 1 --no-std-crt0 --nostdinc --nostdlib \
	--code-loc 0x100 --data-loc 0x0000 \
	$(addprefix -I,$(INCLUDE_DIRS))

PROGRAMS := TULIBC TARITH TARGS
SOURCES := $(addprefix src/,$(addsuffix .c,$(PROGRAMS)))
COMS := $(addprefix $(BIN_DIR)/,$(addsuffix .COM,$(PROGRAMS)))
RELS := $(addprefix $(OBJ_DIR)/,$(addsuffix .rel,$(PROGRAMS)))
LOGS := $(addprefix $(BIN_DIR)/,$(addsuffix .txt,$(PROGRAMS)))

.PHONY: all build run clean

all: build

build: $(COMS)

run: build $(LOGS)

clean:
	rm -rf "$(BUILD_DIR)" "$(BIN_DIR)"

$(BIN_DIR) $(BUILD_DIR) $(OBJ_DIR):
	mkdir -p "$@"

$(OBJ_DIR)/%.rel: src/%.c include/testfw.h | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c "$<" -o "$@"

$(BIN_DIR)/%.COM: $(OBJ_DIR)/%.rel | $(BIN_DIR) $(BUILD_DIR)
	$(CC) $(CFLAGS) \
		"$(ROOT_DIR)/bin/crt0.rel" \
		"$<" \
		"$(ROOT_DIR)/bin/ulibc.lib" \
		"$(ROOT_DIR)/bin/usdcc.lib" \
		-o "$(BUILD_DIR)/$*.ihx"
	$(MAKEBIN) -p "$(BUILD_DIR)/$*.ihx" "$@"

$(BIN_DIR)/TULIBC.txt: $(BIN_DIR)/TULIBC.COM $(BIN_DIR)/TARGS.COM $(BIN_DIR)/TARITH.COM scripts/run_z80pack_tests.sh | $(BIN_DIR)
	./scripts/run_z80pack_tests.sh "$(ROOT_DIR)" "$(EMU_DIR)" "$(BIN_DIR)" TULIBC

$(BIN_DIR)/TARITH.txt: $(BIN_DIR)/TULIBC.txt
	@:

$(BIN_DIR)/TARGS.txt: $(BIN_DIR)/TULIBC.txt
	@:
