`timescale 1ns/1ps
 
module tb_mxa;
 
logic clk = 0;
logic reset;
 
top dut(.*);
 
always #5 clk = ~clk;
 
int cycle = 0;
int start_cycle = -1;
int latch_cycle = -1;
int matrix_a [16];
int matrix_b [16];
int expected_c [16];
int error_count;
logic [63:0] matrix_a_digits = 64'h1234_4123_3412_2341;
logic [63:0] matrix_b_digits = 64'h2143_1234_3412_4321;
 
always @(posedge clk) begin
    cycle <= cycle + 1;
    #1;
    if (dut.memory.matmul.state == 2'd1 && start_cycle < 0) start_cycle = cycle;
    if (dut.memory.matmul.state == 2'd3 && latch_cycle < 0) latch_cycle = cycle;
end
 
initial begin
    for (int index = 0; index < 16; index++) begin
        matrix_a[index] = matrix_a_digits[(15 - index)*4 +: 4];
        matrix_b[index] = matrix_b_digits[(15 - index)*4 +: 4];
    end
 
    for (int row = 0; row < 4; row++) begin
        for (int column = 0; column < 4; column++) begin
            expected_c[row*4 + column] = 0;
            for (int term = 0; term < 4; term++)
                expected_c[row*4 + column] += matrix_a[row*4 + term] * matrix_b[term*4 + column];
        end
    end
 
    for (int index = 0; index < 64; index++) dut.fetch.imem.array[index] = 32'h00000013;
    $readmemh("programs/mxa_test.hex", dut.fetch.imem.array);
 
    reset = 1;
    @(posedge clk); #1;
    reset = 0;
    repeat(150) @(posedge clk); #1;
 
    error_count = 0;
    for (int index = 0; index < 16; index++) begin
        if (dut.memory.matmul.matrix_A[index] !== matrix_a[index]) begin
            error_count++;
            $display("MISMATCH: stored A[%0d][%0d] = %0d, expected %0d", index/4, index%4, dut.memory.matmul.matrix_A[index], matrix_a[index]);
        end
        if (dut.memory.matmul.matrix_B[index] !== matrix_b[index]) begin
            error_count++;
            $display("MISMATCH: stored B[%0d][%0d] = %0d, expected %0d", index/4, index%4, dut.memory.matmul.matrix_B[index], matrix_b[index]);
        end
        if (dut.decode.reg_file.regs[9 + index] !== expected_c[index]) begin
            error_count++;
            $display("MISMATCH: C[%0d][%0d] = %0d, expected %0d", index/4, index%4, dut.decode.reg_file.regs[9 + index], expected_c[index]);
        end
    end
 
    $display("");
    $display("Matrix A (written by the CPU into the accelerator):");
    for (int row = 0; row < 4; row++)
        $display("  %3d %3d %3d %3d",
                 dut.memory.matmul.matrix_A[row*4],
                 dut.memory.matmul.matrix_A[row*4 + 1],
                 dut.memory.matmul.matrix_A[row*4 + 2],
                 dut.memory.matmul.matrix_A[row*4 + 3]);
 
    $display("");
    $display("Matrix B (written by the CPU into the accelerator):");
    for (int row = 0; row < 4; row++)
        $display("  %3d %3d %3d %3d",
                 dut.memory.matmul.matrix_B[row*4],
                 dut.memory.matmul.matrix_B[row*4 + 1],
                 dut.memory.matmul.matrix_B[row*4 + 2],
                 dut.memory.matmul.matrix_B[row*4 + 3]);
 
    $display("");
    $display("Matrix C = A x B (computed by the accelerator, read back by the CPU):");
    for (int row = 0; row < 4; row++)
        $display("  %3d %3d %3d %3d",
                 dut.decode.reg_file.regs[9 + row*4],
                 dut.decode.reg_file.regs[10 + row*4],
                 dut.decode.reg_file.regs[11 + row*4],
                 dut.decode.reg_file.regs[12 + row*4]);
 
    $display("");
    if (error_count == 0)
        $display("MXA TEST PASSED: A and B stored correctly, all 16 elements of C match the expected 4x4 product");
    else
        $display("MXA TEST FAILED: %0d mismatches", error_count);
 
    $display("Accelerator: start accepted at cycle %0d, results latched at cycle %0d (%0d cycles: 1 clear + 4 compute + 1 latch)",
             start_cycle, latch_cycle, latch_cycle - start_cycle + 1);
 
    $finish;
end
 
endmodule
 