# Not file target
.PHONY: all install install-scripts install-ssh install-systemd

### Macros ###
SRCS_SCRIPTS = $(wildcard usr/local/sbin/*)
SRCS_SSH = $(wildcard etc/ssh/*)
SRCS_SYSTEMD = $(wildcard etc/systemd/system/*)

# For testing set PREFIX in shell environment, like
# $ PREFIX=/tmp/test make
DEST_SCRIPTS = $(PREFIX)/usr/local/sbin
DEST_SSH = $(PREFIX)/etc/ssh
DEST_SYSTEMD = $(PREFIX)/etc/systemd/system

### Targets ###
all: install

install: install-scripts install-ssh install-systemd

install-scripts:
	install -d $(DEST_SCRIPTS)
	install -m 0744 $(SRCS_SCRIPTS) $(DEST_SCRIPTS)

# Note that these will still need to be 'enable'd and
# 'start'd manually with systemctl
install-systemd:
	install -d $(DEST_SYSTEMD)
	install -m 0744 $(SRCS_SYSTEMD) $(DEST_SYSTEMD)

install-ssh:
	install -d $(DEST_SSH)
	install -m 0644 $(SRCS_SSH) $(DEST_SSH)

