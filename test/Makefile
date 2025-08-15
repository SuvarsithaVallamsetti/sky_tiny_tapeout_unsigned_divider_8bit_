# PDK and build settings
PDK_ROOT ?= /home/runner/pdk
PDK      ?= sky130A
DESIGN   ?= project.v

SIM_BUILD_DIR = sim_build/gl
TEST_DIR      = test

# Default target
all: gds

# Gate-level simulation
gl_test:
	@echo "=== Running Gate-Level Simulation ==="
	mkdir -p $(TEST_DIR) $(SIM_BUILD_DIR)
	iverilog -o $(SIM_BUILD_DIR)/sim.vvp \
		-I $(PDK_ROOT)/$(PDK)/libs.ref/sky130_fd_sc_hd/verilog \
		-I $(PDK_ROOT)/$(PDK)/libs.ref/sky130_fd_io/verilog \
		-Y .v \
		$(DESIGN).v tb.v
	vvp $(SIM_BUILD_DIR)/sim.vvp

# Physical GDS build (placeholder)
gds:
	@echo "=== Building GDS (placeholder) ==="

# Clean build files
clean:
	rm -rf $(SIM_BUILD_DIR) $(TEST_DIR)

.PHONY: all gl_test gds clean
