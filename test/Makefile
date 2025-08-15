# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# Defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v

# PDK root and name should be set by CI or environment
PDK_ROOT ?= /home/runner/pdk
PDK ?= sky130

ifneq ($(GATES),yes)

# ------------------------------
# RTL simulation
# ------------------------------
SIM_BUILD         = sim_build/rtl
VERILOG_SOURCES  += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

else

# ------------------------------
# Gate level simulation
# ------------------------------
SIM_BUILD         = sim_build/gl
COMPILE_ARGS    += -DGL_TEST
COMPILE_ARGS    += -DFUNCTIONAL
COMPILE_ARGS    += -DSIM

# Select correct standard cell + IO library based on PDK
ifeq ($(PDK),sky130)
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_io/verilog/sky130_fd_io.v
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v
else ifeq ($(PDK),sky130A)
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_io/verilog/sky130_fd_io.v
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v
else ifeq ($(PDK),ihp-sg13g2)
    VERILOG_SOURCES += $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_io/verilog/sg13g2_io.v
    VERILOG_SOURCES += $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_stdcell/verilog/sg13g2_stdcell.v
else
    $(error Unsupported PDK: $(PDK))
endif


# Gate-level netlist (provided by GDS action workflow)
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

# Allow sharing configuration between design and testbench via `include`:
COMPILE_ARGS += -I$(SRC_DIR)

# Include the testbench sources:
VERILOG_SOURCES += $(PWD)/tb.v
TOPLEVEL = tb

# MODULE is the basename of the Python test file
MODULE = test

# Include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
