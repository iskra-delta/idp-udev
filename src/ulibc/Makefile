# Virtual paths are all subfolders!
DIRS	=	$(wildcard */)
vpath %.c $(DIRS)
vpath %.s $(DIRS)
vpath %.h $(DIRS)

# Source files.
C_SRCS	=	$(wildcard *.c) $(wildcard */*.c)
S_SRCS	=	$(filter-out $(CRT0).s, $(wildcard */*.s)) \
			$(filter-out $(CRT0).s, $(wildcard *.s))
OBJS	=	$(addprefix $(BUILD_DIR)/, \
				$(notdir \
					$(patsubst %.c,%.rel,$(C_SRCS)) \
					$(patsubst %.s,%.rel,$(S_SRCS)) \
				) \
			)
TARGET = ulibc

# Add our include folder to fags
CFLAGS	+= 	-I $(ROOT)/lib/libtiles

# Rules.
.PHONY: all
all:	$(BUILD_DIR)/$(TARGET).lib $(BUILD_DIR)/$(CRT0).rel

$(BUILD_DIR)/$(TARGET).lib: $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

$(BUILD_DIR)/%.rel:	%.s
	$(AS) $(ASFLAGS) $(BUILD_DIR)/$(@F) $(CURDIR)/$<

$(BUILD_DIR)/%.rel: %.c
	$(CC) -c -o $(BUILD_DIR)/$(@F) $(CURDIR)/$< $(CFLAGS)

$(BUILD_DIR)/%.rel: %.h

.PHONY: clean
clean:
