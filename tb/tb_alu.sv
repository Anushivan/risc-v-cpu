`timescale 1ns/1ps

module tb_alu;
logic [31:0] a,b;
logic [2:0] alu_ctrl;
logic [31:0] result;
logic zero;

alu dut (.*);


initial begin
    $dumpfile ("sim/dump.vcd");
    $dumpvars(0, tb_alu);



    a = 32'd1; b = 32'd1; alu_ctrl = 3'b000; 
    #10;
    $display("The result is: %0d (Expected 2) and the zero counter is %0d (expected 0)", result, zero);

    a = 32'd3; b = 32'd2; alu_ctrl = 3'b001; 
    #10;
    $display("The result is: %0d (Expected 1) and the zero counter is %0d (expected 0)", result, zero);

    a = 32'b1010; b = 32'b0101; alu_ctrl = 3'b010; 
    #10;
    $display("The result is: %0d (Expected 0) and the zero counter is %0d (expected 1)", result, zero);

    a = 32'b1; b = 32'b1; alu_ctrl = 3'b011; 
    #10;
    $display("The result is: %0d (Expected 1) and the zero counter is %0d (expected 0)", result, zero);

    a = 32'b1101; b = 32'b1100; alu_ctrl = 3'b100; 
    #10;
    $display("The result is: %0d (Expected 1) and the zero counter is %0d (expected 0)", result, zero);

    a = 32'd4; b = 32'd8; alu_ctrl = 3'b101; 
    #10;
    $display("The result is: %0d (Expected 1) and the zero counter is %0d (expected 0)", result, zero);

    $finish;

end

endmodule


