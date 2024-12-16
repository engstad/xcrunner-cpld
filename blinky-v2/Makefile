all: blinky.bin

PART := xc2c64a-5-vq44

blinky.json: blinky.v
	yosys -p "read_verilog blinky.v; synth_coolrunner2 -top top -json blinky.json"

# blinky.crbit: blinky.json
#	xc2par --part ${PART} blinky.json --crbit blinky.crbit

blinky.jed: blinky.json
	xc2par --part ${PART} blinky.json --jed blinky.jed

blinky.bin: blinky.jed
	xc2jed2bin -j blinky.jed -o blinky.bin

#blinky.bin2: blinky.crbit
#	xc2jed2bin --crbit blinky.crbit blinky.bin2

#blinky.jed2: blinky.crbit
#	xc2crbit2jed blinky.crbit > blinky.jed2

clean:
	-rm -f *.json *.crbit *.jed *.jed2 *.bin
