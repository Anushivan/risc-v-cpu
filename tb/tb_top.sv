`timescale 1ns/1ps
module tb_top;
logic clk, reset;
single_cycle_top dut(.*);
always #5 clk = ~clk;
initial begin
    $dumpfile("sim/dump.vcd");
    $dumpvars(0, tb_top);
    clk = 0;
    reset = 1;
    @(posedge clk); #1;
    reset = 0;
    @(posedge clk); #1;  // jal x1
    $display("after jal: pc=%0d", dut.pc);
    @(posedge clk); #1;  // addi x3 (skipped)
    @(posedge clk); #1;  // addi x4 (skipped)
    @(posedge clk); #1;  // addi x5
    if (dut.reg_file.regs[3] == 32'd0)
        $display("PASS: x3 = %0d", dut.reg_file.regs[3]);
    else
        $display("FAIL: x3 = %0d (expected 0)", dut.reg_file.regs[3]);
    if (dut.reg_file.regs[4] == 32'd0)
        $display("PASS: x4 = %0d", dut.reg_file.regs[4]);
    else
        $display("FAIL: x4 = %0d (expected 0)", dut.reg_file.regs[4]);
    if (dut.reg_file.regs[5] == 32'd1)
        $display("PASS: x5 = %0d", dut.reg_file.regs[5]);
    else
        $display("FAIL: x5 = %0d (expected 1)", dut.reg_file.regs[5]);
    if (dut.reg_file.regs[1] == 32'h00000004)
        $display("PASS: x1 (return addr) = 0x%08h", dut.reg_file.regs[1]);
    else
        $display("FAIL: x1 (return addr) = 0x%08h (expected 0x00000004)", dut.reg_file.regs[1]);

        $display("correct encoding: %h", {1'b0, 10'b0000001100, 1'b0, 8'b00000000, 5'b00001, 7'b1101111});
        $display("correct: %h", {1'b0, 10'b0000000110, 1'b0, 8'b00000000, 5'b00001, 7'b1101111});
    $finish;
end
endmodule