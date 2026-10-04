# RISC-V CPU + Matrix Multiplier Accelerator

A 32-bit RISC-V CPU in SystemVerilog (an **RV32I subset**) with a single-cycle core, a 5-stage pipelined core, and a memory-mapped 4×4 matrix multiplier accelerator that the CPU drives with ordinary load/store instructions. Simulated in Intel Questa.

**Status: work in progress.** Verified with directed tests so far.

| Component | Status |
|---|---|
| Single-cycle core | Working, directed tests |
| 5-stage pipeline (forwarding, load-use stall, branch/jump flush) | Working for the supported subset |
| Matrix multiplier accelerator | Working end to end on a 4×4 test program |
| Verification beyond directed tests | Planned (see roadmap) |

## Supported instructions

`add`, `sub`, `and`, `or`, `xor`, `slt`, `addi`, `andi`, `ori`, `xori`, `slti`, `lw`, `sw`, `beq`, `jal`

## Pipeline

- Stages: IF, ID, EX, MEM, WB, with registers between each stage.
- Data forwarding from EX/MEM and MEM/WB into EX; a 1-cycle stall on load-use.
- Branches and `jal` resolve in EX and flush IF/ID and ID/EX (2-cycle penalty). No branch prediction.
- Memories: 64-word instruction memory and 64-word data memory.

*Block diagram: TODO*

## Matrix accelerator

Multiplies two 4×4 signed 32-bit matrices (`C = A × B`) with 16 MAC units, one per output element. After a start is accepted it takes 6 cycles: 1 clear, 4 compute, 1 latch.

| Address | Register |
|---|---|
| `0x1000–0x103F` | Matrix A (write) |
| `0x1040–0x107F` | Matrix B (write) |
| `0x1080–0x10BF` | Matrix C (read) |
| `0x10C0` | Control: bit 0 = start |
| `0x10C4` | Status: bit 0 = busy, bit 1 = done |

Software flow: store A and B, write 1 to control, poll status until done, load C. See `programs/mxa_test.hex`.

## Verification status

**Exists:** directed pipeline tests (addi, add, forwarding, load-use stall, beq, jal), a MAC unit test, and an end-to-end accelerator test that checks C against a product computed in the testbench.

**Does not exist yet:** random testing against a reference model, assertions, functional coverage, official RISC-V ISA tests.

## Roadmap

1. **Verification:** self-checking regression, Python reference model with random hazard-biased programs, SVA, hazard coverage.
2. **Complete RV32I** and run the official `riscv-arch-test`.
3. **Accelerator:** software-vs-hardware cycle benchmark, parameterized size and INT8 support, DMA/burst access.
4. **Synthesis:** Quartus Fmax and area for single-cycle vs pipeline, with and without the accelerator.
