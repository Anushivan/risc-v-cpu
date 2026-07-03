module imm_gen(
input logic [31:0] instruction,
output logic [31:0] imm
);

always @(*) begin

case(instruction[6:0])

7'b0010011: imm = {{20{instruction[31]}}, instruction[31:20]}; //ADDI
7'b0000011: imm = {{20{instruction[31]}}, instruction[31:20]}; //LW
7'b0100011: imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // SW
7'b1100011: imm = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; //BEQ
7'b1101111: imm = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0}; //JAL
default: imm = 32'b0;
endcase

end


endmodule