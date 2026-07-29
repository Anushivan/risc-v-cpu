# RISC-V CPU

A 32-bit RISC-V processor implemented in SystemVerilog. Includes a complete single-cycle implementation and a fully working 5-stage pipeline with forwarding, hazard detection, and control hazard handling.

## Current Progress

**Single-Cycle (complete)**
- [x] ALU
- [x] Register file
- [x] Immediate generator
- [x] Control unit
- [x] Instruction memory
- [x] Data memory
- [x] Top-level integration
- [x] Tested: add, addi, lw, sw, beq (taken + not-taken), jal

**Pipeline (complete)**
- [x] IF stage
- [x] ID stage
- [x] EX stage
- [x] MEM stage
- [x] WB stage
- [x] Pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB)
- [x] Forwarding unit (RAW data hazards)
- [x] Hazard detection unit (load-use stall)
- [x] Control hazard flush logic (branches and jumps)
- [x] Tested: addi, add, load-use stall, branch, jal

**Next Steps**
- [ ] UVM testbench with self-checking scoreboard
- [ ] SystemVerilog assertions
- [ ] Functional coverage
- [ ] Matrix multiplier extension

## Tools Used
* **HDL:** SystemVerilog
* **Simulator:** Intel Questa (Pipeline), Icarus Verilog (Single Cycle)
* **Waveform Viewer:** GTKWave / Questa
* **Environment:** WSL2 / VS Code

## How to Run

### Single-Cycle (Icarus Verilog)

Install Icarus:
```bash
sudo apt install iverilog
```

Compile and run:
```bash
iverilog -g2012 -o sim/sim_top tb/tb_top.sv src/single_cycle/single_cycle_top.sv src/single_cycle/instruction_memory.sv src/single_cycle/data_memory.sv src/single_cycle/register_file.sv src/single_cycle/alu.sv src/single_cycle/control_unit.sv src/single_cycle/imm_gen.sv && vvp sim/sim_top
```

### Pipeline (Intel Questa)

Compile and run using the TCL script:
```bash
vsim -c -do compile_pipeline.tcl
```

### View waveform
```bash
gtkwave sim/dump.vcd
```