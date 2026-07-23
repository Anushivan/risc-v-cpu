`timescale 1ns/1ps

module tb_pipeline;

logic clk, reset;

top dut(.*);

always #5 clk = ~clk;

initial begin

$dumpfile("sim/dump.vcd");
$dumpvars(0,tb_pipeline);

clk = 0;

$readmemh("programs/pipeline_test_addi.hex", dut.fetch.imem.array);

reset = 1;
@(posedge clk); #1;
reset = 0;
repeat(10) @(posedge clk); #1;


if (dut.decode.reg_file.regs[1] == 5) begin
    $display("Test Passed: x1 == %0d", dut.decode.reg_file.regs[1]);
end 
else begin
    $display("Test Failed: x1 == %0d", dut.decode.reg_file.regs[1]);
end

if (dut.decode.reg_file.regs[2] == 32'hFFFFFFFD) begin
    $display("Test Passed: x2 == %0d", $signed(dut.decode.reg_file.regs[2]));
end 
else begin
    $display("Test Failed: x2 == %0d", $signed(dut.decode.reg_file.regs[2]));
end

if (dut.decode.reg_file.regs[3] == 32'hFFFFFFF9) begin
    $display("Test Passed: x3 == %0d", $signed(dut.decode.reg_file.regs[3]));
end 
else begin
    $display("Test Failed: x3 == %0d", $signed(dut.decode.reg_file.regs[3]));
end



$readmemh("programs/pipeline_test_add.hex", dut.fetch.imem.array);

reset = 1;
@(posedge clk); #1;
reset = 0;
repeat(20) @(posedge clk); #1;

if (dut.decode.reg_file.regs[3] == 15) begin
    $display("Test Passed: x3 == %0d", dut.decode.reg_file.regs[3]);
end 
else begin
    $display("Test Failed: x3 == %0d", dut.decode.reg_file.regs[3]);
end






$finish;

end

endmodule