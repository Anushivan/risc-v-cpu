module wb_stage(
input logic [31:0] mem_wb_read_data,
input logic [31:0] mem_wb_result,
input logic [31:0] mem_wb_pc_add_4,
input logic [4:0] mem_wb_rd,
input logic mem_wb_reg_write,
input logic mem_wb_mem_to_reg,
input logic mem_wb_jal,
output logic [31:0] wb_write_data,
output logic [4:0] wb_rd,
output logic wb_reg_write
);


assign wb_write_data = mem_wb_jal ? mem_wb_pc_add_4 : (mem_wb_mem_to_reg ? mem_wb_read_data : mem_wb_result);
assign wb_rd = mem_wb_rd;
assign wb_reg_write = mem_wb_reg_write;


endmodule