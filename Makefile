# Not file target
.PHONY: install install-scripts install-systemd

### Macros ###
SRCS_SCRIPTS = $(wildcard usr/local/sbin/*)
SRCS_SYSTEMD = $(wildcard etc/systemd/system/*)

# For testing set PREFIX in shell environment, like
# $ PREFIX=/tmp/test make
DEST_SCRIPTS = $(PREFIX)/usr/local/sbin
DEST_SYSTEMD = $(PREFIX)/etc/systemd/system

### Targets ###
all: install

install: install-scripts install-systemd

install-scripts:
	install -d $(DEST_SCRIPTS)
	install -m 0744 $(SRCS_SCRIPTS) $(DEST_SCRIPTS)

# Note that these will still need to be 'enable'd and
# 'start'd manually with systemctl
install-systemd:
	install -d $(DEST_SYSTEMD)
	install -m 0744 $(SRCS_SYSTEMD) $(DEST_SYSTEMD)

