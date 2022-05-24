# We only allow compilation on linux!
ifneq ($(shell uname), Linux)
$(error OS must be Linux!)
endif

# Check if all required tools are on the system.
REQUIRED = sdcc sdar sdasz80 sdldz80 sdobjcopy sed cpmcp
K := $(foreach exec,$(REQUIRED),\
    $(if $(shell which $(exec)),,$(error "$(exec) not found. Please install or add to path.")))

# Global settings: folders.
export ROOT 		=	$(realpath .)
export BUILD_DIR	=	$(ROOT)/build
export BIN_DIR		=	$(ROOT)/bin
export SRC_DIR		=	$(ROOT)/src
export INC_DIR		=	$(ROOT)/include \
						$(SRC_DIR)
export CRT0			=	crt0

# Globa settings: 8 bit tools.
export CC			=	sdcc
export CFLAGS		=	--std-c11 -mz80 --debug --nostdinc \
						$(addprefix -I,$(INC_DIR))
export AS			=	sdasz80
export ASFLAGS		=	-xlos -g
export AR			=	sdar
export ARFLAGS		=	-rc

# Rules.
.PHONY: all
all:	mkdirs $(SRC_DIR) install

.PHONY: $(SRC_DIR)
$(SRC_DIR):
	$(MAKE) -C $@

.PHONY: mkdirs
mkdirs:
	# Create build dir.
	mkdir -p $(BUILD_DIR)
	# And bin dir.
	mkdir -p $(BIN_DIR)

.PHONY: install
install:
	cp $(BUILD_DIR)/*.lib $(BIN_DIR)
	cp $(BUILD_DIR)/$(CRT0).rel $(BIN_DIR)

.PHONY: clean
clean:
	rm -f -r $(BIN_DIR)
	rm -f -r $(BUILD_DIR)