`timescale 1ns/1ps

module tb_data_memory;

logic [31:0] address;
logic clk;
logic we;
logic [31:0] write_data;
logic [31:0] read_data;



data_memory dut (.*);


always #5 clk = ~clk;

initial begin
    
$dumpfile("dump.vcd");
$dumpvars(0, tb_data_memory);

clk = 0;


we = 1; address = 32'b101; write_data = 32'd42;
@(posedge clk); #1;
we = 0;
#1;

if (read_data == 32'd42)begin
    $display("PASS: Expected output was 42 and we got %0d", read_data);
end
else begin
    
$display("Fail: Expected output was 42 and we got %0d", read_data);

end


#1;
    
address = 32'b111; we = 1; write_data = 32'd56;
@(posedge clk); #1;
we = 0;
#1;
if (read_data == 32'd56)begin
    $display("PASS: Expected output was 56 and we got %0d", read_data);
end
else begin
    
$display("Fail: Expected output was 56 and we got %0d", read_data);

end



end



endmodule