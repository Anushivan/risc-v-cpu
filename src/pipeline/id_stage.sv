module id_stage(
    input logic [31:0] if_id_instruction,
    input logic [31:0] if_id_pc_add_4,
    input logic clk,
    input logic we,
    input logic [4:0] write_rd,
    input logic [31:0] write_data,
    output logic reg_write,
    output logic mem_to_reg,
    output logic mem_write,
    output logic branch,
    output logic alu_src,
    output logic [2:0] alu_ctrl,
    output logic jal,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2,
    output logic [31:0] imm,
    output logic [31:0] pc_add_4,
    output logic [4:0] rd,
    output logic [4:0] rs1,
    output logic [4:0] rs2
);


assign rs1 = if_id_instruction[19:15];
assign rs2 = if_id_instruction[24:20];
assign rd = if_id_instruction[11:7];
assign pc_add_4 = if_id_pc_add_4;


control_unit c_unit (
    .instruction (if_id_instruction),
    .*
);


register_file reg_file (
    .rd(write_rd),
    .*
);

imm_gen immgen(
    .instruction (if_id_instruction),
    .*
    );

endmodule