ISE := /opt/Xilinx/14.7/ISE_DS/ISE
#ISE := c:/Xilinx/14.7/ISE_DS/ISE
ISE_BIN := $(ISE)/bin/lin64
XST := $(ISE_BIN)/xst
NGB := $(ISE_BIN)/ngdbuild
PAR := $(ISE_BIN)/par
TRC := $(ISE_BIN)/trce
BITGEN := $(ISE_BIN)/bitgen

PRJ := main

## CPLD
#CHIP := xc9572xl
#SPEED := 7
#PACK := vq44

## XC2C32A-6QFG32C
#CHIP := xc2c32a
#SPEED := 6
#PACK := qfg32

# XC2C32A-4-VQ44
CHIP := xc2c32a
SPEED := 4
PACK := vq44

PART := $(CHIP)-$(SPEED)-$(PACK)

V_SRCS := top.v

INC := -y $(ISE)/verilog/src/unisims -y $(ISE)/verilog/src/simprims

WD := work
PB := $(WD)/$(PRJ)
SVF := $(PRJ).svf

XSTFLAGS := -opt_mode Speed -opt_level 1 -verilog2001 YES -rtlview YES
CPLDFITFLAGS := -slew fast -power std -terminate keeper -unused float -optimize speed -init low

.PHONY: all clean

all: $(PB).tim $(SVF)

edf: main.ngo

$(WD):
	mkdir -p $(WD)

main.ngo: main.edf
	$(ISE_BIN)/edif2ngd -a main.edf main.ngo

$(PB).ngc: $(V_SRCS) Makefile
	@[ ! -e $(WD) ] && mkdir $(WD) || true
	@echo "Generating $(PB).prj..."
	@rm -f $(PB).prj
	@for i in $(V_SRCS); do \
		echo "verilog $(PRJ) $$i" >> $(PB).prj; \
	done
	@echo "DEFAULT_SEARCH_ORDER" > $(PB).lso
	@echo "set -tmpdir $(WD) -xsthdpdir $(WD)" > $(PB).xst
	@echo "run -ifn $(PB).prj -ifmt mixed -top top -ofn $@ -ofmt NGC -p $(PART) $(XSTFLAGS) -lso $(PB).lso" >> $(PB).xst
	$(XST) -ifn $(PB).xst -ofn $(PB)_xst.log

$(PB).ngd: $(PB).ngc $(PACK).ucf
	cd $(WD); $(NGB) -p $(PART) -uc ../$(PACK).ucf ../$< ../$@

#$(PB).ngd: main.ngo $(PACK).ucf
#	cd $(WD); $(NGB) -p $(PART) -uc ../$(PACK).ucf ../$< ../$@


$(PB).vm6: $(PB).ngd
	cd $(WD); $(ISE_BIN)/cpldfit -p $(PART) ../$<

$(PB).tim: $(PB).vm6
	cd $(WD); $(ISE_BIN)/taengine -l ../$@ -detail -f $(PRJ) ../$<

$(PB).jed: $(PB).vm6
	cd $(WD); $(ISE_BIN)/hprep6 -i ../$<

$(SVF): $(PB).jed
	@echo "Generating $(PB).cmd..."
	@echo "setmode -bscan" > $(PB).cmd
	@echo "setcable -p svf -file ../$@" >> $(PB).cmd
	@echo "addDevice -p 1 -file ../$<" >> $(PB).cmd
	@echo "erase -p 1 -o" >> $(PB).cmd
	@echo "program -p 1" >> $(PB).cmd
	@echo "quit" >> $(PB).cmd
	cd $(WD); $(ISE_BIN)/impact -batch $(PRJ).cmd

%: $(WD)/%
	@sed -e 's/FREQUENCY .* HZ/FREQUENCY 5E5 HZ/' $< > $@
	@echo "Output $@ is ready"

clean:
	rm -rf $(WD) $(SVF) _xmsgs
