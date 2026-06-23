# RISC-V Single-Cycle CPU
A 32-bit RISC-V processor implemented in SystemVerilog.

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

**Pipeline (in progress)**
- [ ] IF stage
- [ ] ID stage
- [ ] EX stage
- [ ] MEM stage
- [ ] WB stage
- [ ] Forwarding unit
- [ ] Hazard detection unit

## Tools Used
* **HDL:** SystemVerilog
* **Simulator:** Verilator
* **Waveform Viewer:** GTKWave
* **Environment:** WSL2 / VS Code

## How to Run

### Install Icarus Verilog
```bash
sudo apt install iverilog
```

### Run a test
```bash
iverilog -g2012 -o sim/sim_top tb/tb_top.sv src/single_cycle/top.sv src/single_cycle/instruction_memory.sv src/single_cycle/data_memory.sv src/single_cycle/register_file.sv src/single_cycle/alu.sv src/single_cycle/control_unit.sv src/single_cycle/imm_gen.sv && vvp sim/sim_top
```

### View waveform
```bash
gtkwave sim/dump.vcd
```
