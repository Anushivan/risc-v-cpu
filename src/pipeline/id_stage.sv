module id_stage(
    input logic [31:0] if_id_instruction,
    input logic [31:0] if_id_pc_add_4,
    input logic clk,
    input logic we,
    input logic reset,
    input logic [4:0] write_rd,
    input logic [31:0] write_data,
    output logic id_reg_write,
    output logic id_mem_to_reg,
    output logic id_mem_write,
    output logic id_branch,
    output logic id_alu_src,
    output logic [2:0] id_alu_ctrl,
    output logic id_jal,
    output logic [31:0] id_read_data1,
    output logic [31:0] id_read_data2,
    output logic [31:0] id_imm,
    output logic [31:0] id_pc_add_4,
    output logic [4:0] id_rd,
    output logic [4:0] id_rs1,
    output logic [4:0] id_rs2
);


assign id_rs1 = if_id_instruction[19:15];
assign id_rs2 = if_id_instruction[24:20];
assign id_rd  = if_id_instruction[11:7];
assign id_pc_add_4 = if_id_pc_add_4;

control_unit c_unit(
    .instruction(if_id_instruction),
    .reg_write(id_reg_write),
    .alu_ctrl(id_alu_ctrl),
    .data_mem_write(id_mem_write),
    .branch(id_branch),
    .mem_to_reg(id_mem_to_reg),
    .alu_src(id_alu_src),
    .jal(id_jal)
);

register_file reg_file(
    .clk(clk),
    .reset(reset),
    .we(we),
    .rs1(id_rs1),
    .rs2(id_rs2),
    .rd(write_rd),
    .write_data(write_data),
    .read_data1(id_read_data1),
    .read_data2(id_read_data2)
);

imm_gen immgen(
    .instruction(if_id_instruction),
    .imm(id_imm)
);

endmodule