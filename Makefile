# Simple LaTeX makefile

TEX_DIRS := bhs dlcs gre math templates white-papers
OTHER_DIRS := apcs apcsp correspondence cv doc ga \
	harvard-dce ia ig input jobs overleaf pc1 princeton \
	robotics stanford-logic uml wps MassBay

PDFLATEX := texi2dvi -p -q
CLEAN := sh clean.sh

all : $(TEX_DIRS)

%.pdf : %.tex
	echo "# $(PDFLATEX) $(notdir $<)"
	$(PDFLATEX) $(notdir $<)

$(TEX_DIRS) $(OTHER_DIRS) : FORCE
	echo "## make $@"
	$(MAKE) -C $@ --makefile=../makefile \
	    $(patsubst %.tex,%.pdf,$(notdir $(wildcard $@/*.tex)))

clean :
	for DIR in $(TEX_DIRS); do echo "## $$DIR"; $(CLEAN) -d $$DIR; done

clean-all :
	for DIR in $(TEX_DIRS); do echo "## $$DIR"; $(CLEAN) -d $$DIR pdf; done
	for DIR in $(OTHER_DIRS); do echo "## $$DIR"; $(CLEAN) -d $$DIR pdf; done

FORCE :

.PHONY : $(OTHER_DIRS)
