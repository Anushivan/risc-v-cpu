`timescale 1ns/1ps

module tb_top;

logic clk;
logic reset;


top dut(.*);

always #5 clk = ~clk;



initial begin
    $dumpfile("sim/dump.vcd");
    $dumpvars(0, tb_top);
    
    clk = 0;
    reset = 1;
    @(posedge clk); #1;
    reset = 0;
    @(posedge clk); #1;
    @(posedge clk); #1;
    @(posedge clk); #1;
    
  
    if (dut.reg_file.regs[3] == 32'd15)
        $display("PASS: x3 = %0d", dut.reg_file.regs[3]);
    else
        $display("FAIL: x3 = %0d (expected 15)", dut.reg_file.regs[3]);
    
    $finish;
end

endmodule