PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

all:

install:
	install -m 0755 wifcap.sh $(BINDIR)/wifcap
