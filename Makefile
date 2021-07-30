# Not file target
.PHONY: all install install-scripts install-ssh install-systemd install-updated-motd

### Macros ###
# For testing set DEST to another value
DEST = /

### Targets ###
all: install

install: install-scripts install-ssh install-systemd install-update-motd

install-scripts:
	./recursive_install.sh usr/local/sbin $(DEST) 0744

# Note that these will still need to be 'enable'd and
# 'start'd manually with systemctl
install-systemd:
	./recursive_install.sh etc/systemd/system $(DEST) 0744

install-ssh:
	./recursive_install.sh etc/ssh $(DEST) 0644

install-update-motd:
	./recursive_install.sh etc/update-motd.d $(DEST) 0644
