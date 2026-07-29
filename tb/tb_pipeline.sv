`timescale 1ns/1ps

module tb_pipeline;

logic clk, reset;

top dut(.*);

always #5 clk = ~clk;

initial begin

$dumpfile("sim/dump.vcd");
$dumpvars(0,tb_pipeline);

clk = 0;


for (int j = 0; j < 64; j = j + 1) 
    dut.fetch.imem.array[j] = 32'h00000013;
$readmemh("programs/test_stall.hex", dut.fetch.imem.array);

//TEST ADDI WITHOUT FORWARDING

$readmemh("programs/pipeline_test_addi.hex", dut.fetch.imem.array);

reset = 1;
@(posedge clk); #1;
reset = 0;
repeat(10) @(posedge clk); #1;


if (dut.decode.reg_file.regs[1] == 5) begin
    $display("Test 1 Passed: x1 == %0d", dut.decode.reg_file.regs[1]);
end 
else begin
    $display("Test 1 Failed: x1 == %0d", dut.decode.reg_file.regs[1]);
end

if (dut.decode.reg_file.regs[2] == 32'hFFFFFFFD) begin
    $display("Test 1 Passed: x2 == %0d", $signed(dut.decode.reg_file.regs[2]));
end 
else begin
    $display("Test 1 Failed: x2 == %0d", $signed(dut.decode.reg_file.regs[2]));
end

if (dut.decode.reg_file.regs[3] == 32'hFFFFFFF9) begin
    $display("Test 1 Passed: x3 == %0d", $signed(dut.decode.reg_file.regs[3]));
end 
else begin
    $display("Test 1 Failed: x3 == %0d", $signed(dut.decode.reg_file.regs[3]));
end

$display("NEXT TEST");

for (int j = 0; j < 64; j = j + 1) 
    dut.fetch.imem.array[j] = 32'h00000013;
$readmemh("programs/test_stall.hex", dut.fetch.imem.array);

//TEST ADDI WITHOUT FORWARDING
$readmemh("programs/pipeline_test_add.hex", dut.fetch.imem.array);

reset = 1;
@(posedge clk); #1;
reset = 0;
repeat(20) @(posedge clk); #1;

if (dut.decode.reg_file.regs[3] == 15) begin
    $display("Test 2 Passed: x3 == %0d", dut.decode.reg_file.regs[3]);
end 
else begin
    $display("Test 2 Failed: x3 == %0d", dut.decode.reg_file.regs[3]);
end


$display("NEXT TEST");

for (int j = 0; j < 64; j = j + 1) 
    dut.fetch.imem.array[j] = 32'h00000013;
$readmemh("programs/test_stall.hex", dut.fetch.imem.array);

//TEST ADD WITH FORWARDING
$readmemh("programs/test_forwarding.hex", dut.fetch.imem.array);

reset = 1;
@(posedge clk); #1;
reset = 0;
repeat(7) @(posedge clk); #1;

if (dut.decode.reg_file.regs[3] == 15) begin
    $display("Test 3 Passed: x3 == %0d", dut.decode.reg_file.regs[3]);
end 
else begin
    $display("Test 3 Failed: x3 == %0d", dut.decode.reg_file.regs[3]);
end



$display("NEXT TEST");

for (int j = 0; j < 64; j = j + 1) 
    dut.fetch.imem.array[j] = 32'h00000013;
$readmemh("programs/test_stall.hex", dut.fetch.imem.array);

//TEST LOAD-USE HAZARD (STALL)
$readmemh("programs/pipeline_test_lw.hex", dut.fetch.imem.array);



reset = 1;
@(posedge clk); #1;
reset = 0;
repeat(15) @(posedge clk); #1;





if (dut.decode.reg_file.regs[3] == 84) begin
    $display("Test 4 Passed: x3 == %0d", dut.decode.reg_file.regs[3]);
end 
else begin
    $display("Test 4 Failed: x3 == %0d", dut.decode.reg_file.regs[3]);
end




$finish;

end

endmodule