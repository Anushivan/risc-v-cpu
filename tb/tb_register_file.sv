`timescale 1ns/1ps

module tb_register_file;
logic clk, we;
logic [4:0] rs1, rs2, rd;
logic [31:0] write_data, read_data1, read_data2;

register_file dut (.*);

always #5 clk = ~clk;

initial begin
    $dumpfile("sim/dump.vcd");
    $dumpvars(0, tb_register_file);    

    clk = 0; we =0;

    rd = 5'd1; write_data = 32'd42; we = 1;
    @(posedge clk); #1;
    we = 0;
    rs1 = 5'd1;
    #1;
    $display("Read x1 = %0d (expect 42)", read_data1);

    rd = 5'd0; write_data = 32'd99; we = 1;
    @(posedge clk); #1;
    we = 0;
    rs1 = 5'd0;
    #1;
    $display("Read x0 = %0d (expect 0)", read_data1);

    rd = 5'd2; write_data = 32'd10; we = 1;
    @(posedge clk); #1;
    rd = 5'd3; write_data = 32'd20; we = 1;
    @(posedge clk); #1;
    we = 0;
    rs1 = 5'd2; rs2 = 5'd3;
    #1;
    $display("Read x2 = %0d (expected 10)", read_data1);
    $display("Read x3 = %0d (expected 20)", read_data2);
    
    $finish;
    end

endmodule


