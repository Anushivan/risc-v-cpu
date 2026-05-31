module top(
input logic clk,
input logic reset
);

logic [31:0] pc, pc_next, pc_add4, pc_branch;

logic [31:0] instruction;

logic reg_write, mem_write, branch, mem_to_reg, alu_src;
logic [2:0] alu_ctrl;

logic [31:0] read_data1, read_data2, write_back;

logic [31:0] alu_input_b, alu_result;
logic zero;

logic [31:0] mem_read_data;

logic [31:0] imm;

logic pc_src;


always_ff @(posedge clk) begin
    

if (reset) pc <= 32'b0;

else pc <= pc_next;

end


assign pc_add4 = pc + 4;
assign pc_branch = pc + imm;
assign pc_src = branch & zero;
assign pc_next = pc_src ? pc_branch : pc_add4;

assign alu_input_b = alu_src ? imm : read_data2;
assign write_back  = mem_to_reg ? mem_read_data : alu_result;

instruction_memory imem(
    .address(pc), 
    .instruction(instruction)
    );

control_unit ctrl_unit(
    .instruction(instruction), 
    .reg_write(reg_write), 
    .alu_ctrl(alu_ctrl), 
    .data_mem_write(mem_write),
    .branch(branch),
    .mem_to_reg(mem_to_reg),
    .alu_src(alu_src)
    );

register_file reg_file(
    .clk(clk),
    .we(reg_write),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .write_data(write_back),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

imm_gen immediate_gen(
    .instruction(instruction),
    .imm(imm)
);

data_memory data_mem(
    .clk(clk),
    .we(mem_write),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(mem_read_data)
);

alu alu_top(
    .a(read_data1),
    .b(alu_input_b),
    .alu_ctrl(alu_ctrl),
    .result(alu_result),
    .zero(zero)
);


endmodule