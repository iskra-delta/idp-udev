TARGET := ugpx

ROOT_DIR := ../..
BUILD_DIR := $(ROOT_DIR)/build/ugpx

CC := sdcc
AS := sdasz80
AR := sdar

CFLAGS := --std-c11 -mz80 -I$(ROOT_DIR)/include/gpx
ASFLAGS := -xlos -g
ARFLAGS := -rc

C_SRCS := $(wildcard *.c)
S_SRCS := $(wildcard *.s)
OBJS := $(patsubst %.c,$(BUILD_DIR)/%.rel,$(C_SRCS)) \
	$(patsubst %.s,$(BUILD_DIR)/%.rel,$(S_SRCS))

LIB := $(BUILD_DIR)/$(TARGET).lib

all: $(LIB)

$(LIB): $(OBJS)
	@mkdir -p "$(BUILD_DIR)"
	@echo "[ar] $@"
	@$(AR) $(ARFLAGS) "$@" $(OBJS)

$(BUILD_DIR)/%.rel: %.c
	@mkdir -p "$(BUILD_DIR)"
	@echo "[cc] $< -> $@"
	@$(CC) $(CFLAGS) -c -o "$@" "$<"

$(BUILD_DIR)/%.rel: %.s
	@mkdir -p "$(BUILD_DIR)"
	@echo "[as] $< -> $@"
	@$(AS) $(ASFLAGS) -o "$@" "$<"

clean:
	@rm -rf "$(BUILD_DIR)"

.PHONY: all clean
