# Simple LaTeX makefile.

TEX_DIRS := doc/apcs doc/bhs doc/dlcs doc/gre doc/math doc/random doc/white-papers templates
OTHER_DIRS := apcs apcsp correspondence cv ga harvard-dce ia ig \
	jobs overleaf pc1 princeton psb \
	robotics stanford-logic uml wps MassBay
MAKEFILE := $(realpath ./Makefile)

PDFLATEX := texi2dvi -p -q
CLEAN := sh clean.sh

all : $(TEX_DIRS)

%.pdf : %.tex
	@echo "# $(PDFLATEX) $(notdir $<)"
	$(PDFLATEX) $(notdir $<)

$(TEX_DIRS) $(OTHER_DIRS) : FORCE
	@echo "## make $@"
	$(MAKE) -C $@ \
	  --makefile=$(MAKEFILE) \
	    $(patsubst %.tex,%.pdf,$(notdir $(wildcard $@/*.tex)))

clean :
	for DIR in $(TEX_DIRS); do echo "## $$DIR"; $(CLEAN) -d $$DIR; done

clean-pdf :
	for DIR in $(TEX_DIRS); do echo "## $$DIR"; $(CLEAN) -d $$DIR pdf; done

clean-all :
	for DIR in $(TEX_DIRS) $(OTHER_DIRS); \
		do echo "## $$DIR"; $(CLEAN) -d $$DIR pdf; done

FORCE :

.PHONY : $(OTHER_DIRS)
