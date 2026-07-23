module instruction_memory(
input logic [31:0] address,
output logic [31:0] instruction
);

logic [31:0] array [0:63];

initial begin


end

assign instruction = array[address >> 2];

endmodule