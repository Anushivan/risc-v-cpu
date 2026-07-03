module register_file (
input logic clk, 
input logic we,
input logic [4:0] rs1,
input logic [4:0] rs2,
input logic [4:0] rd,
input logic [31:0] write_data,
output logic [31:0] read_data1,
output logic [31:0] read_data2
);

  logic [31:0] regs [31:0];
  assign read_data1 = (rs1==5'b0) ? 32'b0 : regs[rs1];
  assign read_data2 = (rs2==5'b0) ? 32'b0 : regs[rs2];

  always_ff @(posedge clk) begin
    if (we && rd != 5'b0)
        regs[rd] <= write_data;
  end


integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        regs[i] = 32'b0;
end


endmodule