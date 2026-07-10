module mem_stage(
input logic [31:0] ex_mem_result,
input logic ex_mem_reg_write,
input logic ex_mem_mem_to_reg,
input logic ex_mem_mem_write,
input logic [4:0] ex_mem_rd,
input logic [31:0] ex_mem_write_data,
input logic [31:0] ex_mem_pc_add_4,
input logic ex_mem_jal,
input logic clk,
output logic [31:0] mem_read_data,
output logic [31:0] mem_result,
output logic [31:0] mem_pc_add_4,
output logic [4:0] mem_rd,
output logic mem_reg_write,
output logic mem_mem_to_reg,
output logic mem_jal
);

assign mem_result = ex_mem_result;
assign mem_pc_add_4 = ex_mem_pc_add_4;
assign mem_rd = ex_mem_rd;
assign mem_mem_to_reg = ex_mem_mem_to_reg;
assign mem_jal = ex_mem_jal;
assign mem_reg_write = ex_mem_reg_write;


data_memory data_mem(
    .address(ex_mem_result),
    .clk(clk),
    .we(ex_mem_mem_write),
    .write_data(ex_mem_write_data),
    .read_data(mem_read_data)
);








endmodule