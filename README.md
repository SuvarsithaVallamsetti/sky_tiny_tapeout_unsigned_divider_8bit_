![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# sky_tiny_tapeout_32bit_Unsigned_Divider

- [Read the documentation for this project](docs/info.md)

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that aims to make it easier and cheaper than ever to get your digital and analog designs manufactured on a real chip.

To learn more and get started, visit https://tinytapeout.com.

---

## Project Overview

This project implements a **32-bit unsigned hardware divider** in Verilog, compatible with the Tiny Tapeout submission flow.  
It takes two 32-bit unsigned integers (`dividend` and `divisor`) and produces both the **quotient** and **remainder**.  
Designed for educational purposes, this project demonstrates how a high-bit-width arithmetic unit can be integrated into a real silicon chip via Tiny Tapeout.

---

## Features

- Open-source HDL design  
- Supports 32-bit unsigned integer division  
- Outputs both quotient and remainder  
- Fully synchronous design (clock + reset)  
- Compatible with Tiny Tapeout I/O interface  
- Simple testbench included for verification  

---

## Design Files

- **src/** – Verilog source files for the divider core and top-level wrapper  
- **test/** – Testbenches and simulation scripts  
- **tt_project.yaml** – Tiny Tapeout project descriptor (pin mapping, metadata)  
- **docs/info.md** – Detailed project documentation  

---

## How to Use

1. **Clone the repository**
   ```bash
   git clone <your-repo-link>
   cd sky_tiny_tapeout_32bit_Unsigned_Divider
   Run simulation
2.Run simulation

3.Generate GDS
Follow Tiny Tapeout's synthesis & GDS flow.

4.Submit to Tiny Tapeout
Use Tiny Tapeout’s submission process for fabrication.

Steps Followed

Project Setup – Cloned Tiny Tapeout template & configured structure.

HDL Coding – Implemented divider core and I/O wrapper.

Simulation – Wrote testbench in Verilog/Cocotb and verified functionality.

Integration – Updated tt_project.yaml with correct pin mapping.

Synthesis & Verification – Ran checks using Tiny Tapeout flow.

Submission – Generated final GDS and submitted for shuttle run.

Testing & Results

Simulation – Verified with various test cases, including edge cases (divide by 1, max values).

Post-fabrication – To be tested on real silicon after chip arrival.

Waveforms – Confirmed correct outputs in GTKWave.

Acknowledgements

Tiny Tapeout community and maintainers.

Open-source EDA tool developers.

Contributors to testing and code review.

Resources

FAQ

Digital design lessons

Learn how semiconductors work

Join the community

Local hardening guide

What next?

Submit your design to the next shuttle

Share your project:

LinkedIn #tinytapeout @TinyTapeout

Mastodon #tinytapeout @matthewvenn

X (Twitter) #tinytapeout @tinytapeout
