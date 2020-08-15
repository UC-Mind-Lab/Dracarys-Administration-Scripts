# Not file target
.PHONY: install install-scripts

### Macros ###
SRCS_SCRIPTS = $(wildcard usr/local/sbin/*)

# For testing set PREFIX in shell environment, like
# $ PREFIX=/tmp/test make
DEST_SCRIPTS = $(PREFIX)/usr/local/sbin

### Targets ###
all: install

install: install-scripts

install-scripts:
	install -d $(DEST_SCRIPTS)
	install -m 0744 $(SRCS_SCRIPTS) $(DEST_SCRIPTS)

