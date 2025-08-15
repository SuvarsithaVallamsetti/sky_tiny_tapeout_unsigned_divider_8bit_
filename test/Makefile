# Paths
PDK_ROOT ?= /home/runner/pdk
PDK      ?= sky130A
STD_CELL_DIR := $(PDK_ROOT)/$(PDK)/libs.ref/sky130_fd_sc_hd/verilog
STD_IO_DIR   := $(PDK_ROOT)/$(PDK)/libs.ref/sky130_fd_io/verilog

BUILD_DIR := sim_build
GL_DIR    := $(BUILD_DIR)/gl
TEST_DIR  := test

# Files
STD_CELL_FILES := \
	$(STD_CELL_DIR)/primitives.v \
	$(STD_CELL_DIR)/sky130_fd_sc_hd.v \
	$(STD_IO_DIR)/sky130_fd_io.v

GL_NETLIST := gate_level_netlist.v
TB_FILE    := tb.v

IVERILOG_FLAGS := -g2012 -DFUNCTIONAL -DUSE_POWER_PINS -Wall

all: gl_test

gl_test: $(GL_DIR)/sim.vvp | $(TEST_DIR)
	@echo "Running gate-level simulation..."
	vvp $<
	@echo "<testsuite></testsuite>" > $(TEST_DIR)/results.xml
	@echo "Simulation complete."

$(GL_DIR)/sim.vvp: $(GL_NETLIST) $(TB_FILE) $(STD_CELL_FILES) | $(GL_DIR)
	iverilog $(IVERILOG_FLAGS) \
		-I$(STD_CELL_DIR) \
		-I$(STD_IO_DIR) \
		-o $@ \
		$^

$(GL_DIR):
	mkdir -p $@

$(TEST_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR) $(TEST_DIR)
