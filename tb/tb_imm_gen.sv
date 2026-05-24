`timescale 1ns/1ps


module tb_imm_gen;


logic [31:0] instruction;
logic [31:0] imm;


imm_gen dut(.*);


initial begin
$dumpfile("sim/dump.vcd");
$dumpvars(0,tb_imm_gen);



instruction = 32'b00000011010100111000000110010011; //ADDI
#10;
if (imm == 53) $display("Test 1 Passed");
else $display("Test 1 Failed");

instruction = 32'b00000000010000000010000010000011; //LW
#10;
if (imm == 4) $display("Test 2 Passed");
else $display("Test 2 Failed");

instruction = 32'b00000000001000000010001000100011; //SW
#10;
if (imm == 4) $display("Test 3 Passed");
else $display("Test 3 Failed");

instruction = 32'b00000000001000000000010001100011; //BEQ
#10;
if (imm == 8) $display("Test 4 Passed");
else $display("Test 4 Failed");

instruction = 32'b00000001000000000000000011101111; //JAL
#10;
if (imm == 16) $display("Test 5 Passed");
else $display("Test 5 Failed");

$finish;
end


endmodule