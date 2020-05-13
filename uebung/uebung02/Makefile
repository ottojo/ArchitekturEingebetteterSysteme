compile:
	mkdir -p ghdl_work
	ghdl -a --workdir=ghdl_work mux.vhd testbench.vhd

.PHONY: run
run: compile
	ghdl -r --workdir=ghdl_work testbench --vcd=ghdl_work/testbench.vcd

.PHONY: wave
wave: run
	gtkwave ghdl_work/testbench.vcd

.PHONY: clean
clean:
	rm -rf ghdl_work
