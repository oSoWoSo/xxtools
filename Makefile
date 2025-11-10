PREFIX ?= /usr/local
LIST = xxadopt xxautobump xxbuild xxcheckorphans
DOCS = README.md

all:

lint: shellcheck shfmt

shellcheck:
	shellcheck $$(shfmt --find .)

shfmt:
	shfmt -d -ci $$(shfmt --find .)

install:
	for file in $(LIST); do \
		install -m 755 $$file $(PREFIX)/bin; \
	done
	for file in $(DOCS); do \
		install -m 644 $$file $(PREFIX)/share/doc/xxtools; \
	done

uninstall:
	for file in $(LIST); do \
		rm -f $(PREFIX)/bin/$$file; \
	done
	for file in $(DOCS); do \
		rm -f $(PREFIX)/share/doc/xxtools/$$file; \
	done
	rmdir -p $(PREFIX)/share/doc/xxtools/ 2>/dev/null || true
	rmdir -p $(PREFIX)/share/doc/ 2>/dev/null || true

.PHONY: all lint shellcheck shfmt install uninstall
