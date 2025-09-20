# Simple LaTeX makefile. 
# Use 'make DIRS=whatever' to build directory in $DIRS or $OTHER.

DIRS ?= doc/apcs doc/bhs doc/dlcs doc/gre doc/math doc/random \
	doc/white-papers templates
OTHER ?= apcs apcsp correspondence cv ga harvard-dce ia ig \
	jobs pc1 psb princeton robotics stanford-logic uml wps MassBay
INPUT := $(wildcard $(dir $(realpath $(lastword $(MAKEFILE_LIST))))input/input-*.tex)
#$(info INPUT: $(INPUT))

MAKEFILE := $(realpath ./Makefile)

PDFLATEX := texi2dvi -p -q
PDFLATEX := latexmk -pdf -quiet
CLEAN := latexmk -c -cd
CLEAN := python3 clean.py
CLEANPDF := latexmk -C -cd
CLEANPDF := python3 clean.py -e pdf

all : $(DIRS)

other : $(OTHER)

$(INPUT) : ;	# never rebuild $(INPUT)

# Making %.tex targets dependent on $(INPUT) yields circular deps.
# Also, changing any input-*.tex will lead to total rebuilds.
#%.tex : $(INPUT)
#	@: $(info $(notdir $*) based on INPUT recipe)

%.pdf : %.tex
	@echo "##################################################"
	@echo "#"
	@echo "# $(notdir $<)"
	@echo "#"
	$(PDFLATEX) $(notdir $<)

$(sort $(DIRS) $(OTHER)) : FORCE
	@echo "##################################################"
	@echo "##"
	@echo "## make $@"
	@echo "##"
	$(MAKE) -C $@ \
	  --makefile=$(MAKEFILE) \
	    $(patsubst %.tex,%.pdf,$(notdir $(wildcard $@/*.tex)))

# Using clean.py for $(CLEAN)

clean :
	@for DIR in $(DIRS); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo $(CLEAN) $$DIR/*.tex; \
		$(CLEAN) $$DIR/*.tex; done

clean-pdf :
	@for DIR in $(DIRS); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo $(CLEANPDF) $$DIR/*.tex; \
		$(CLEANPDF) $$DIR/*.tex; done

clean-all :
	@for DIR in $(DIRS) $(OTHER); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo $(CLEAN) $$DIR/*.tex; \
		$(CLEAN) $$DIR/*.tex; done

clean-all-pdf :
	@for DIR in $(DIRS) $(OTHER); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo $(CLEANPDF) $$DIR/*.tex; \
		$(CLEANPDF) $$DIR/*.tex; done

FORCE :
