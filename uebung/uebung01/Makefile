compile:
	mkdir -p ghdl_work
	ghdl -a --workdir=ghdl_work hello.vhd

.PHONY: run
run: compile
	ghdl -r --workdir=ghdl_work hello

.PHONY: clean
clean:
	rm -rf ghdl_work
