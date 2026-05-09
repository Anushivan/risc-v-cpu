# RISC-V Single-Cycle CPU
A 32-bit RISC-V processor implemented in SystemVerilog.

## Current Progress
- [x] Register File
- [x] ALU
- [ ] Control Unit
- [ ] Top-level Integration

## Tools Used
* **HDL:** SystemVerilog
* **Simulator:** Verilator
* **Waveform Viewer:** GTKWave
* **Environment:** WSL2 / VS Code

## How to Run
1. Install Verilator: `sudo apt install verilator`
2. Compile: `verilator -Wall --trace -cc top.sv --exe sim_main.cpp`
3. Run: `./obj_dir/Vtop`
4. View Waves: `gtkwave dump.vcd`
