module instruction_memory(
input logic [31:0] address,
output logic [31:0] instruction
);

logic [31:0] array [63:0];

initial begin

$readmemh("programs/test1.hex", array);

end

assign instruction = array[address >> 2];

endmodule