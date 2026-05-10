`timescale 1ns/1ps

module tb_data_memory;

logic [31:0] address,
logic clk,
logic we,
logic [31:0] write_data,
logic [31:0] read_data
logic [31:0] memory [63:0];


tb_data_memory dut (.*);


initial begin
    
$dumpfile("dump.vcd");
$dumpvars(0, tb_data_memory);


we = 0; address = 32'b1; 






end





endmodule