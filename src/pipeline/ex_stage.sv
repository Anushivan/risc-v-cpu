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
input logic [1:0] forward1,
input logic [1:0] forward2,
input logic [31:0] frwd_ex_mem_result,
input logic [31:0] frwd_wb_write_data,
output logic [31:0] ex_result,
output logic ex_zero,
output logic ex_pc_src,
output logic [31:0] ex_branch_target,
output logic ex_reg_write,
output logic ex_mem_to_reg,
output logic ex_mem_write,
output logic [4:0] ex_rd,
output logic [31:0] ex_write_data,
output logic [31:0] ex_pc_add_4,
output logic ex_jal
);

logic [31:0] alu_input_a;
logic [31:0] alu_input_b;



always_comb begin
    case(forward1)
    2'b00: alu_input_a = id_ex_read_data1;
    2'b10: alu_input_a = frwd_ex_mem_result;
    2'b01: alu_input_a = frwd_wb_write_data;
    default: alu_input_a = id_ex_read_data1;
    endcase

    case(forward2)
    2'b00: alu_input_b = id_ex_alu_src ? id_ex_imm : id_ex_read_data2;
    2'b10: alu_input_b = id_ex_alu_src ? id_ex_imm : frwd_ex_mem_result;
    2'b01: alu_input_b = id_ex_alu_src ? id_ex_imm : frwd_wb_write_data;
    default: alu_input_b = id_ex_alu_src ? id_ex_imm : id_ex_read_data2;
    endcase
end


assign ex_reg_write = id_ex_reg_write;
assign ex_mem_to_reg = id_ex_mem_to_reg;
assign ex_mem_write = id_ex_mem_write;
assign ex_rd  = id_ex_rd;
assign ex_write_data = (forward2 == 2'b10) ? frwd_ex_mem_result : (forward2 == 2'b01) ? frwd_wb_write_data : id_ex_read_data2;
assign ex_pc_add_4 = id_ex_pc_add_4;
assign ex_jal = id_ex_jal;
assign ex_branch_target = id_ex_pc_add_4 - 4 + id_ex_imm;
assign ex_pc_src = (id_ex_branch & ex_zero) | id_ex_jal;


alu alu_call(
    .a(alu_input_a),
    .b(alu_input_b),
    .alu_ctrl(id_ex_alu_ctrl),
    .result(ex_result),
    .zero(ex_zero)
);






endmodule