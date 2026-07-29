module alu(
input logic [31:0] a,
input logic [31:0] b,
input logic [2:0] alu_ctrl,
output logic [31:0] result,
output logic zero
);

always_comb begin 

case (alu_ctrl)
    3'b000: result = a+b;
    3'b001: result = a-b;
    3'b010: result = a&b;
    3'b011: result = a|b;
    3'b100: result = a^b;
    3'b101: result = (a<b) ? 32'b1 : 32'b0;
    default: result = 32'b0;


endcase

zero = (result == 32'b0) ? 1'b1 : 1'b0;

end





endmodule