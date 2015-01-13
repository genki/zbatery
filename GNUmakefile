all::
RSYNC_DEST := zbatery.bogomip.org:/srv/zbatery
rfpackage := zbatery
PLACEHOLDERS := zbatery_1

man-rdoc: man html
doc:: man-rdoc
include pkg.mk

base_bins := zbatery
bins := $(addprefix bin/, $(base_bins))
man1_bins := $(addsuffix .1, $(base_bins))
man1_paths := $(addprefix man/man1/, $(man1_bins))
clean:
	-$(MAKE) -C Documentation clean

man html:
	$(MAKE) -C Documentation install-$@

pkg_extra += $(man1_paths)
doc::

all:: test
test:
	$(MAKE) -C t
.PHONY: man html
