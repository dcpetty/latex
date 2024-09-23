# Simple LaTeX makefile.

DIRS ?= doc/apcs doc/bhs doc/dlcs doc/gre doc/math doc/random doc/white-papers templates
OTHER := apcs apcsp correspondence cv ga harvard-dce ia ig \
	jobs overleaf pc1 princeton psb \
	robotics stanford-logic uml wps MassBay
MAKEFILE := $(realpath ./Makefile)

PDFLATEX := texi2dvi -p -q
PDFLATEX := latexmk -pdf -quiet
CLEAN := python3 clean.py
CLEAN := latexmk

all : $(DIRS)

# Using latexmk for $(PDFLATEX)

%.pdf : %.tex
	@echo "##################################################"
	@echo "#"
	@echo "# $(notdir $<)"
	@echo "#"
	$(PDFLATEX) $(notdir $<)

$(DIRS) $(OTHER) : FORCE
	@echo "##################################################"
	@echo "##"
	@echo "## make $@"
	@echo "##"
	$(MAKE) -C $@ \
	  --makefile=$(MAKEFILE) \
	    $(patsubst %.tex,%.pdf,$(notdir $(wildcard $@/*.tex)))

# Using latexmk for $(CLEAN)

clean :
	@for DIR in $(DIRS); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo "$(CLEAN) -c -cd $$DIR/*.tex"; \
		$(CLEAN) -c -cd $$DIR/*.tex; done

clean-pdf :
	@for DIR in $(DIRS); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo "$(CLEAN) -C -cd $$DIR/*.tex"; \
		$(CLEAN) -C -cd $$DIR/*.tex; done

clean-all :
	@for DIR in $(DIRS) $(OTHER); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo "$(CLEAN) -c -cd $$DIR/*.tex"; \
		$(CLEAN) -c -cd $$DIR/*.tex; done

clean-all-pdf :
	@for DIR in $(DIRS) $(OTHER); do \
		echo "##################################################"; \
		echo "##"; \
		echo "## $$DIR"; echo "##"; \
		echo "$(CLEAN) -C -cd $$DIR/*.tex"; \
		$(CLEAN) -C -cd $$DIR/*.tex; done

FORCE :

.PHONY : $(OTHER)
