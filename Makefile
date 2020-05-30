VIEWER=xdg-open

.PHONY: pdf
pdf:
	pandoc $(shell cat pandoc_list.txt) -o main.pdf -s

show: pdf
	screen -dm $(VIEWER) main.pdf

clean:
	rm main.pdf
