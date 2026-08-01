# RISC-V CPU + Matrix Multiplier Accelerator
A 32-bit RISC-V processor implemented in SystemVerilog. Includes a complete single-cycle implementation and a fully working 5-stage pipeline with forwarding, hazard detection, and control hazard handling. Currently being extended with a memory-mapped matrix multiplier accelerator.

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

**Matrix Multiplier Accelerator (in progress)**
- [ ] Memory-mapped register interface
- [ ] Accelerator control registers (start, status, dimensions)
- [ ] Compute core (parallel multiply-accumulate)
- [ ] Integration with RISC-V memory bus
- [ ] Software-controlled via load/store instructions from the CPU
- [ ] End-to-end test v1: CPU program drives accelerator and verifies result
- [ ] Compute core v2: parallel MAC array
- [ ] End-to-end test v2: verify performance improvement (cycles taken)

**Verification (planned)**
- [ ] UVM testbench with self-checking scoreboard
- [ ] SystemVerilog assertions
- [ ] Functional coverage
