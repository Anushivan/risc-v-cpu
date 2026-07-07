module ex_stage(

input logic id_ex_reg_write,
input logic id_ex_mem_to_reg,
input logic id_ex_mem_write,
input logic id_ex_branch,
input logic id_ex_alu_src,
input logic [2:0] id_ex_alu_ctrl,
input logic id_ex_jal,
input logic [31:0] id_ex_read_data1,
input logic [31:0] id_ex_read_data2,
input logic [31:0] id_ex_imm,
input logic [31:0] id_ex_pc_add_4,
input logic [4:0] id_ex_rd,
input logic [4:0] id_ex_rs1,
input logic [4:0] id_ex_rs2,
output logic [31:0] result,
output logic zero,
output logic pc_src,
output logic [31:0] branch_target,
output logic reg_write,
output logic mem_to_reg,
output logic mem_write,
output logic [4:0] rd,
output logic [31:0] write_data,
output logic [31:0] pc_add_4,
output logic jal
);

logic [31:0] alu_input_b;

assign alu_input_b = id_ex_alu_src ? id_ex_imm : id_ex_read_data2;
assign reg_write = id_ex_reg_write;
assign mem_to_reg = id_ex_mem_to_reg;
assign mem_write = id_ex_mem_write;
assign rd  = id_ex_rd;
assign write_data = id_ex_read_data2;
assign pc_add_4 = id_ex_pc_add_4;
assign jal = id_ex_jal;
assign branch_target = id_ex_pc_add_4 - 4 + id_ex_imm;
assign pc_src = (id_ex_branch & zero) | id_ex_jal;


alu alu_call(
    .a(id_ex_read_data1),
    .b(alu_input_b),
    .alu_ctrl(id_ex_alu_ctrl),
    .result(result),
    .zero(zero)
);






endmodule