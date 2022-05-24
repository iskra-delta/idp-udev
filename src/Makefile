# Folders
SUBDIRS = usdcc ulibc ugpx

# Rules.
.PHONY: all
all:	$(SUBDIRS) 

.PHONY: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@
	
.PHONY: clean
clean: