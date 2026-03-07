TARGET := ulibc

ROOT_DIR := ../..
BUILD_DIR := $(ROOT_DIR)/build

CC ?= sdcc
AS ?= sdasz80
AR ?= sdar

CFLAGS += -I$(ROOT_DIR)/lib/libtiles

C_SRCS := $(wildcard *.c)
S_SRCS := $(filter-out $(CRT0).s,$(wildcard *.s))
OBJS := $(patsubst %.c,$(BUILD_DIR)/%.rel,$(C_SRCS)) \
	$(patsubst %.s,$(BUILD_DIR)/%.rel,$(S_SRCS))

LIB := $(BUILD_DIR)/$(TARGET).lib
CRT0_OBJ := $(BUILD_DIR)/$(CRT0).rel

all: $(LIB) $(CRT0_OBJ)

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
	@rm -f "$(LIB)" "$(CRT0_OBJ)" $(OBJS)

.PHONY: all clean
