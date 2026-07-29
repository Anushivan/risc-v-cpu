module data_memory(
input logic [31:0] address,
input logic clk,
input logic we,
input logic [31:0] write_data,
output logic [31:0] read_data
);

logic [31:0] memory [63:0];


always_comb begin

if (!we) begin

read_data = memory[address];

end 

end


always_ff @(posedge clk) begin
    
if (we) begin

memory[address] <= write_data;

end

end

endmodule