`timescale 1ns/1ps

module tb_control_unit;

logic [31:0] instruction;
logic reg_write;
logic [2:0] alu_ctrl;
logic data_mem_write;
logic branch;
logic mem_to_reg;
logic alu_src;


control_unit dut(.*);


initial begin
    
$dumpfile("sim/dump.vcd");
$dumpvars(0,tb_control_unit);


instruction = 32'b00000000001100010000000010110011;
if(reg_write == 1 && alu_ctrl == 3'b000 && data_mem_write == 0 && branch == 0 && mem_to_reg == 0 && alu_src == 0) $display("Test for Add Passed");
else $display("Test for Add Failed");
#10;

instruction = 32'b00000000000000010010000010000011;
if(reg_write == 1 && alu_ctrl == 3'b000 && data_mem_write == 0 && branch == 0 && mem_to_reg == 1 && alu_src == 1) $display("Test for LW Passed");
else $display("Test for LW Failed");
#10;

instruction = 32'b00000000001100010010000000100011;
if(reg_write == 0 && alu_ctrl == 3'b000 && data_mem_write == 1 && branch == 0 && mem_to_reg == 0 && alu_src == 1) $display("Test for SW Passed");
else $display("Test for SW Failed");
#10;

instruction = 32'b00000000001000001000000001100011;
if(reg_write == 0 && alu_ctrl == 3'b001 && data_mem_write == 0 && branch == 1 && mem_to_reg == 0 && alu_src == 0) $display("Test for beq Passed");
else $display("Test for beq Failed");
#10;

instruction = 32'b00000000010100010000000010010011;
if(reg_write == 1 && alu_ctrl == 3'b000 && data_mem_write == 0 && branch == 0 && mem_to_reg == 0 && alu_src == 1) $display("Test for ADDI Passed");
else $display("Test for ADDI Failed");
#10;

instruction = 32'b00000000000000000000000011101111;
if(reg_write == 1 && alu_ctrl == 3'b000 && data_mem_write == 0 && branch == 1 && mem_to_reg == 0 && alu_src == 1) $display("Test for JAL Passed");
else $display("Test for JAL Failed");






$finish;

end



endmodule

