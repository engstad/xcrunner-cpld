TOP := passthrough

all: ${TOP}.jed ${TOP}.bin

${TOP}.json: ${TOP}.v
	yosys -p "read_verilog ${TOP}.v; synth_coolrunner2 -top top -json ${TOP}.json"

${TOP}.jed: ${TOP}.json
	xc2par --part xc2c64a-5-vq44 ${TOP}.json --jed ${TOP}.jed

${TOP}.bin: ${TOP}.jed
	xc2jed2bin -j ${TOP}.jed -o ${TOP}.bin

# ${TOP}.crbit: ${TOP}.json
# 	xc2par --part xc2c32a-4-vq44 ${TOP}.json --crbit ${TOP}.crbit

# ${TOP}.bin2: ${TOP}.crbit
# 	xc2jed2bin --crbit ${TOP}.crbit ${TOP}.bin2

# ${TOP}.jed2: ${TOP}.crbit
# 	xc2crbit2jed ${TOP}.crbit > ${TOP}.jed2

clean:
	-rm -f *.json *.crbit *.jed *.jed2 *.bin
