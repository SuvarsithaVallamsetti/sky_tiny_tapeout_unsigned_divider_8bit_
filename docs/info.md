
## How it works
This project is an **8-bit unsigned divider** designed in Verilog.
It takes an 8-bit dividend and an 8-bit divisor as inputs and produces:
- **8-bit Quotient** → dividend / divisor
- **8-bit Remainder** → dividend % divisor

### Main components:
- **Division Logic**: Implements unsigned division.
- **Quotient Output**: Holds the integer division result.
- **Remainder Output**: Holds the remainder after division.
- **Tiny Tapeout-Compatible Interface**: Inputs and outputs are mapped to the 8 available user pins (`ui` and `uo`).

The design operates combinationally, producing results immediately after inputs are applied.

---

## How to test
To test this divider:

1. Ensure all Verilog source files (e.g., `divider8.v`) are in the `src/` directory.
2. Navigate to the `test/` folder.
3. Run the cocotb-based testbench:
   ```bash
   cd test
   make
4. The testbench:
     - Sets input values for dividend and divisor
     - Waits for the design to compute
     - Reads the quotient and remainder outputs
     - Uses assertions to check correctness

5. To try different values:
     - Open the `test_divider.py` file in the `test/` directory
     - Modify the `test_vectors` list to include your own dividend/divisor pairs

External hardware
-----------------
Not applicable — this project runs entirely in simulation and does not require external hardware.
