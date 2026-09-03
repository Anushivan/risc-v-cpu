`timescale 1ns/1ps

module tb_mac_unit;

logic clk;
logic clear;
logic enable;
logic [31:0] a;
logic [31:0] b;
logic [31:0] result;


mac_unit dut(.*);


always #5 clk = ~clk;

initial begin
    $dumpfile("sim/dump.vcd");
    $dumpvars(0, tb_mac_unit);  

    //Basic function test
    clk = 0; clear = 0; enable = 0; a = 0; b = 0;
    @(posedge clk);#1; clear = 1;
    @(posedge clk);#1;
    clear = 0; enable = 1; a = 2; b = 3;
    @(posedge clk);#1;
    a = 3; b = 4;
    @(posedge clk);#1;
    enable = 0; 



    if (result == 18) begin
        $display("TEST 1 PASSED: result = %0d", result);
    end
    else begin
        $display("TEST 1 FAILED: result = %0d", result);
    end

   
   //Reset mid sequence test
    @(posedge clk);#1; clear = 1;
    @(posedge clk);#1;  clear = 0; enable = 1; a = 10; b = 10;
    @(posedge clk);#1;
    
       if (result == 100) begin
        $display("TEST 2 PASSED: result = %0d", result);
    end
    else begin
        $display("TEST 2 FAILED: result = %0d", result);
    end

    //Full calculation for a new term in matrix C
    clear = 0; enable = 0; a = 0; b = 0;
    @(posedge clk);#1; clear = 1;
    @(posedge clk);#1;
    clear = 0; enable = 1;
    @(posedge clk);#1;
    a = 10; b = 10;
    @(posedge clk);#1;
    a = 4; b = 4;
    @(posedge clk);#1;
    a = 5; b= 8;
    @(posedge clk);#1;
    a=3; b=7;
    @(posedge clk);#1;

    if (result == 177)begin
        $display("TEST 3 PASSED: result = %0d", result);
    end
    else begin
        $display("TEST 3 FAILED: result = %0d", result);
    end



$finish;


end



endmodule

