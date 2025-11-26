SHELL := /bin/bash

LATEX      := pdflatex
LATEXFLAGS := -interaction=nonstopmode -halt-on-error -file-line-error
MAIN_TEX   := main.tex
JOBNAME    := main
OUT_PDF    := $(JOBNAME).pdf

TEX_SOURCES := $(wildcard *.tex) $(shell find chapters -name '*.tex')
BIB_SOURCES := $(wildcard *.bib)
FIGURES     := $(shell find figures -type f 2>/dev/null)

.PHONY: all pdf clean distclean

all: pdf

pdf: $(OUT_PDF)

$(OUT_PDF): $(TEX_SOURCES) $(BIB_SOURCES) $(FIGURES)
	$(LATEX) $(LATEXFLAGS) -jobname=$(JOBNAME) $(MAIN_TEX)
	bibtex $(JOBNAME)
	$(LATEX) $(LATEXFLAGS) -jobname=$(JOBNAME) $(MAIN_TEX)
	$(LATEX) $(LATEXFLAGS) -jobname=$(JOBNAME) $(MAIN_TEX)

clean:
	rm -f \
		$(JOBNAME).aux \
		$(JOBNAME).bbl \
		$(JOBNAME).bcf \
		$(JOBNAME).blg \
		$(JOBNAME).log \
		$(JOBNAME).out \
		$(JOBNAME).toc \
		$(JOBNAME).lof \
		$(JOBNAME).lot \
		$(JOBNAME).run.xml \
		$(JOBNAME).synctex.gz

distclean: clean
	rm -f $(OUT_PDF)
