# We only allow compilation on linux!
ifneq ($(shell uname), Linux)
$(error OS must be Linux!)
endif

# Global settings: folders.
export ROOT 		=	$(realpath .)
export BUILD_DIR	=	$(ROOT)/build
export BIN_DIR		=	$(ROOT)/bin
export SRC_DIR		=	$(ROOT)/src
export INC_DIR		=	$(ROOT)/include \
						$(SRC_DIR)
export CRT0			=	crt0

export DOCKER        ?= docker
export SDCC_IMAGE    ?= wischner/sdcc-z80:latest
export CPM_TEST_IMAGE ?= idp-udev-cpmtest:latest
export Z80PACK_REF   ?= 91fd28eb04e675c2127df88ed3f40675e15282e2
export HOST_UID      := $(shell id -u)
export HOST_GID      := $(shell id -g)

DOCKER_MAKE = $(DOCKER) run --rm \
				-u $(HOST_UID):$(HOST_GID) \
				-v $(ROOT):$(ROOT) \
				-w $(ROOT) \
				-e IN_DOCKER=1 \
				$(SDCC_IMAGE) \
				make -C $(ROOT)

DOCKER_TEST_MAKE = $(DOCKER) run --rm \
				-u $(HOST_UID):$(HOST_GID) \
				-v $(ROOT):$(ROOT) \
				-w $(ROOT) \
				-e IN_DOCKER=1 \
				$(CPM_TEST_IMAGE) \
				make -C $(ROOT)

ifeq ($(IN_DOCKER),1)
# Global settings: 8 bit tools (inside container).
export SDCC_BIN		?=	$(if $(wildcard /opt/sdcc/bin/sdcc),/opt/sdcc/bin,/usr/bin)
export CC			=	$(SDCC_BIN)/sdcc
export CFLAGS		=	--std-c11 -mz80 --debug \
						--no-std-crt0 --nostdinc --nostdlib \
						$(addprefix -I,$(INC_DIR))
export AS			=	$(SDCC_BIN)/sdasz80
export ASFLAGS		=	-xlos -g
export AR			=	$(SDCC_BIN)/sdar
export ARFLAGS		=	-rc

.PHONY: all install clean test test-image test-build test-run $(SRC_DIR)
all: __inner_all
install: __inner_install
clean: __inner_clean
test: __inner_test
test-build: __inner_test_build
test-run: __inner_test_run

$(SRC_DIR):
	$(MAKE) -C $@
else
# Check if docker is on the system.
REQUIRED = docker
K := $(foreach exec,$(REQUIRED),\
    $(if $(shell which $(exec)),,$(error "$(exec) not found. Please install or add to path.")))

.PHONY: all install clean test test-image test-build test-run $(SRC_DIR)
all:
	$(DOCKER_MAKE) __inner_all
install:
	$(DOCKER_MAKE) __inner_install
clean:
	$(DOCKER_MAKE) __inner_clean
test-image:
	$(DOCKER) build --build-arg Z80PACK_REF=$(Z80PACK_REF) -t $(CPM_TEST_IMAGE) -f $(ROOT)/test/docker/Dockerfile $(ROOT)
test-build: test-image
	$(DOCKER_TEST_MAKE) __inner_clean
	$(DOCKER_TEST_MAKE) __inner_test_build
test-run: test-build
	$(DOCKER_TEST_MAKE) __inner_test_run
test: test-run

$(SRC_DIR):
	$(DOCKER_MAKE) -C $(SRC_DIR)
endif

.PHONY: __inner_all
__inner_all: mkdirs $(SRC_DIR) __inner_install

.PHONY: mkdirs
mkdirs:
	# Create build dir.
	mkdir -p $(BUILD_DIR)
# And bin dir.
	mkdir -p $(BIN_DIR)

.PHONY: __inner_install
__inner_install:
	cp $(BUILD_DIR)/*.lib $(BIN_DIR)
	cp $(BUILD_DIR)/ugpx/*.lib $(BIN_DIR)
	cp $(BUILD_DIR)/$(CRT0).rel $(BIN_DIR)
	mkdir -p $(BIN_DIR)/include/gpx
	cp $(ROOT)/include/*.h $(BIN_DIR)/include
	cp $(ROOT)/include/gpx/*.h $(BIN_DIR)/include/gpx

.PHONY: __inner_clean
__inner_clean:
	rm -f -r $(BIN_DIR)
	rm -f -r $(BUILD_DIR)

.PHONY: __inner_test_build
__inner_test_build: __inner_all
	$(MAKE) -C $(ROOT)/test build

.PHONY: __inner_test_run
__inner_test_run: __inner_test_build
	$(MAKE) -C $(ROOT)/test run

.PHONY: __inner_test
__inner_test: __inner_test_run
