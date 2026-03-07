TARGET := usdcc

ROOT_DIR := ../..
BUILD_DIR := $(ROOT_DIR)/build

CC ?= sdcc
AS ?= sdasz80
AR ?= sdar

CFLAGS += -I$(ROOT_DIR)/lib/libtiles

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
	@$(CC) -c -o "$@" "$<" $(CFLAGS)

$(BUILD_DIR)/%.rel: %.s
	@mkdir -p "$(BUILD_DIR)"
	@echo "[as] $< -> $@"
	@$(AS) $(ASFLAGS) "$@" "$<"

clean:
	@rm -f "$(LIB)" $(OBJS)

.PHONY: all clean
