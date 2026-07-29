module instruction_memory(
input logic [31:0] address,
output logic [31:0] instruction
);

logic [31:0] array [0:63];

integer i;
initial begin
    for (i = 0; i < 64; i = i + 1)
        array[i] = 32'h00000013;
end

assign instruction = array[address >> 2];

endmodule