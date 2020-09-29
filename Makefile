PANDOC_BASE_OPTIONS=--standalone  --filter pandoc-citeproc
PANDOC_HTML_OPTIONS=$(PANDOC_BASE_OPTIONS) --toc -w html5 --css=styling.css --mathjax
PANDOC_PDF_OPTIONS=$(PANDOC_BASE_OPTIONS) -V links-as-notes=true --pdf-engine=xelatex

all: pdf html vorlesung-html vorlesung-html

styling.css:
	curl -L -O https://b.enjam.info/panam/styling.css

.PHONY: pdf
pdf:
	pandoc $(shell cat pandoc_list.txt) -o main.pdf $(PANDOC_PDF_OPTIONS)

.PHONY: html
html: styling.css
	pandoc $(shell cat pandoc_list.txt) -o index.html $(PANDOC_HTML_OPTIONS)

clean:
	rm main.pdf || true
	rm index.html || true
	rm vl.pdf || true
	rm vl.html || true
	rm styling.css || true

.PHONY: vorlesung-html
vorlesung-html: styling.css
	pandoc $(shell cat vorlesung.txt) -o vl.html $(PANDOC_HTML_OPTIONS)

.PHONY: vorlesung-pdf
vorlesung-pdf:
	pandoc $(shell cat vorlesung.txt) -o vl.pdf $(PANDOC_PDF_OPTIONS)
