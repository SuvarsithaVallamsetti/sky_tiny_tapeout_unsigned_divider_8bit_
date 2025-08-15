# Files & directories
OUTDIR   = test
TB       = $(OUTDIR)/tb.v
SRC      = src/project.v
VVP_FILE = $(OUTDIR)/tb.vvp
VCD_FILE = $(OUTDIR)/tb.vcd
XML_FILE = $(OUTDIR)/results.xml

# Default
all: run

# Ensure test folder exists
$(OUTDIR):
	mkdir -p $(OUTDIR)

# Compile testbench
$(VVP_FILE): $(TB) $(SRC) | $(OUTDIR)
	iverilog -o $(VVP_FILE) $(TB) $(SRC)

# Run sim and always create results.xml
run: $(VVP_FILE)
	@echo "=== Running simulation ==="
	@if vvp $(VVP_FILE); then \
	    echo "Simulation passed."; \
	    echo '<?xml version="1.0" encoding="UTF-8"?>' > $(XML_FILE); \
	    echo '<testsuite name="divider_tb" tests="3" failures="0"></testsuite>' >> $(XML_FILE); \
	else \
	    echo "Simulation failed."; \
	    echo '<?xml version="1.0" encoding="UTF-8"?>' > $(XML_FILE); \
	    echo '<testsuite name="divider_tb" tests="3" failures="1">' >> $(XML_FILE); \
	    echo '<testcase classname="divider" name="Simulation">' >> $(XML_FILE); \
	    echo '<failure message="Simulation failed"/>' >> $(XML_FILE); \
	    echo '</testcase></testsuite>' >> $(XML_FILE); \
	fi

# Clean target for CI
clean:
	rm -f $(VVP_FILE) $(VCD_FILE) $(XML_FILE)
