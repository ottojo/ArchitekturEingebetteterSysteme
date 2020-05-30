VIEWER=xdg-open

.PHONY: pdf
pdf:
	pandoc $(shell cat pandoc_list.txt) -o main.pdf -s

show: pdf
	screen -dm $(VIEWER) main.pdf

styling.css:
	curl -L -O https://b.enjam.info/panam/styling.css

.PHONY: html
html: styling.css
	pandoc $(shell cat pandoc_list.txt) -o index.html -s --toc -w html5 --css=styling.css

clean:
	rm main.pdf || true
	rm index.html || true
	rm styling.css || true
