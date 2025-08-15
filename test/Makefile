# ---------------------------
# Project variables
# ---------------------------
PDK_ROOT ?= /path/to/your/pdk
PDK      ?= sky130A

# Design files
RTL_DIR        := rtl
TB_DIR         := test
BUILD_DIR      := sim_build

# Standard cell libraries for GL simulation
STD_CELL_DIR   := $(PDK_ROOT)/$(PDK)/libs.ref/sky130_fd_sc_hd/verilog
STD_IO_DIR     := $(PDK_ROOT)/$(PDK)/libs.ref/sky130_fd_io/verilog

STD_CELL_FILES := \
	$(STD_CELL_DIR)/primitives.v \
	$(STD_CELL_DIR)/sky130_fd_sc_hd.v \
	$(STD_IO_DIR)/sky130_fd_io.v

# Your synthesized netlist (GL)
GL_NETLIST := gate_level_netlist.v

# Testbench
TB_FILE := $(TB_DIR)/tb.v

# Icarus Verilog compile flags
IVERILOG_FLAGS := -g2012 -Wall

# ---------------------------
# Targets
# ---------------------------

all: gl_test

# Gate-level simulation
gl_test: $(BUILD_DIR)/gl/sim.vvp
	@echo "Running GL simulation..."
	vvp $<

# Compile gate-level simulation
$(BUILD_DIR)/gl/sim.vvp: $(GL_NETLIST) $(TB_FILE) $(STD_CELL_FILES) | $(BUILD_DIR)/gl
	iverilog $(IVERILOG_FLAGS) \
		-I$(RTL_DIR) \
		-I$(STD_CELL_DIR) \
		-I$(STD_IO_DIR) \
		-o $@ \
		$^

$(BUILD_DIR)/gl:
	mkdir -p $@

# Clean
clean:
	rm -rf $(BUILD_DIR) $(TB_DIR)/*.vcd $(TB_DIR)/*.xml

.PHONY: all gl_test clean
