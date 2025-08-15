# test/Makefile

TB       = tb.v
SRC      = ../src/tt_um_unsigned_divider.v
OUTDIR   = test
VVP_FILE = $(OUTDIR)/tb.vvp
VCD_FILE = $(OUTDIR)/tb.vcd
XML_FILE = $(OUTDIR)/results.xml

all: run

# Create output folder
$(OUTDIR):
	mkdir -p $(OUTDIR)

# Compile simulation
$(VVP_FILE): $(TB) $(SRC) | $(OUTDIR)
	iverilog -o $(VVP_FILE) $(TB) $(SRC)

# Run simulation and ensure results.xml exists
run: $(VVP_FILE)
	@echo "=== Running simulation ==="
	@if vvp $(VVP_FILE); then \
	    echo "Simulation completed successfully."; \
	else \
	    echo "Simulation failed."; \
	fi
	@# Ensure XML file exists for CI
	@if [ ! -f $(XML_FILE) ]; then \
	    echo '<?xml version="1.0" encoding="UTF-8"?>' > $(XML_FILE); \
	    echo '<testsuite name="divider_tb" tests="0" failures="1">' >> $(XML_FILE); \
	    echo '<testcase classname="divider" name="Simulation Failed">' >> $(XML_FILE); \
	    echo '<failure message="Simulation did not produce results"/>' >> $(XML_FILE); \
	    echo '</testcase></testsuite>' >> $(XML_FILE); \
	fi

clean:
	rm -rf $(OUTDIR)
