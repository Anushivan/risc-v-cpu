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


logic [31:0] matmul_address;
logic [31:0] matmul_write_data;
logic matmul_we;
logic [31:0] matmul_read_data;
logic [31:0] data_mem_address;
logic [31:0] data_mem_write_data;
logic data_mem_we;
logic [31:0] data_mem_read_data;

assign mem_result = ex_mem_result;
assign mem_pc_add_4 = ex_mem_pc_add_4;
assign mem_rd = ex_mem_rd;
assign mem_mem_to_reg = ex_mem_mem_to_reg;
assign mem_jal = ex_mem_jal;
assign mem_reg_write = ex_mem_reg_write;


address_decoder addr_dec(
    .address(ex_mem_result),
    .write_data(ex_mem_write_data),
    .we(ex_mem_mem_write),
    .data_mem_read_data(data_mem_read_data),
    .matmul_read_data(matmul_read_data),
    .data_mem_address(data_mem_address),
    .data_mem_write_data(data_mem_write_data),
    .data_mem_we(data_mem_we),
    .matmul_address(matmul_address),
    .matmul_write_data(matmul_write_data),
    .matmul_we(matmul_we),
    .read_data(mem_read_data)
);
 
data_memory data_mem(
    .address(data_mem_address),
    .clk(clk),
    .we(data_mem_we),
    .write_data(data_mem_write_data),
    .read_data(data_mem_read_data)
);


matmul_unit matmul(
    .clk(clk),
    .reset(reset),
    .address(matmul_address),
    .write_data(matmul_write_data),
    .we(matmul_we),
    .read_data(matmul_read_data)
);



endmodule