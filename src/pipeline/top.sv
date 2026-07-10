module top(
    input logic clk,
    input logic reset
);

//PC COUNTER
logic [31:0] pc, pc_next;

always_ff @(posedge clk) begin
if (reset == 1) pc <= 32'b0;
else pc <= pc_next;
end

assign pc_next = ex_pc_src ? ex_branch_target : if_pc_add_4;

//IF STAGE
logic [31:0] if_instruction;
logic [31:0] if_pc_add_4;

if_stage fetch(.*);

// IF/ID pipeline register
logic [31:0] if_id_instruction;
logic [31:0] if_id_pc_add_4;

always_ff @(posedge clk) begin
    if (reset) begin
        if_id_instruction <= 32'b0;
        if_id_pc_add_4 <= 32'b0;
    end
    else begin
        if_id_instruction <= if_instruction;
        if_id_pc_add_4 <= if_pc_add_4;
    end
end

//ID STAGE
logic id_reg_write;
logic id_mem_to_reg;
logic id_mem_write;
logic id_branch;
logic id_alu_src;
logic [2:0] id_alu_ctrl;
logic id_jal;
logic [31:0] id_read_data1;
logic [31:0] id_read_data2;
logic [31:0] id_imm;
logic [31:0] id_pc_add_4;
logic [4:0] id_rd;
logic [4:0] id_rs1;
logic [4:0] id_rs2;

id_stage decode(
    .clk(clk),  //CAN CAHNGE TO .* SOON
    .if_id_instruction(if_id_instruction),
    .if_id_pc_add_4(if_id_pc_add_4),
    .we(wb_reg_write),
    .write_rd(wb_rd),
    .write_data(wb_write_data),
    .reg_write(id_reg_write),
    .mem_to_reg(id_mem_to_reg),
    .mem_write(id_mem_write),
    .branch(id_branch),
    .alu_src(id_alu_src),
    .alu_ctrl(id_alu_ctrl),
    .jal(id_jal),
    .read_data1(id_read_data1),
    .read_data2(id_read_data2),
    .imm(id_imm),
    .pc_add_4(id_pc_add_4),
    .rd(id_rd),
    .rs1(id_rs1),
    .rs2(id_rs2)
);

// ID/EX pipeline register
logic id_ex_reg_write;
logic id_ex_mem_to_reg;
logic id_ex_mem_write;
logic id_ex_branch;
logic id_ex_alu_src;
logic [2:0] id_ex_alu_ctrl;
logic id_ex_jal;
logic [31:0] id_ex_read_data1;
logic [31:0] id_ex_read_data2;
logic [31:0] id_ex_imm;
logic [31:0] id_ex_pc_add_4;
logic [4:0] id_ex_rd;
logic [4:0] id_ex_rs1;
logic [4:0] id_ex_rs2;

always_ff @(posedge clk) begin
    if (reset) begin
        id_ex_reg_write <= 0;
        id_ex_mem_to_reg <= 0;
        id_ex_mem_write <= 0;
        id_ex_branch <= 0;
        id_ex_alu_src <= 0;
        id_ex_alu_ctrl <= 3'b0;
        id_ex_jal <= 0;
        id_ex_read_data1 <= 32'b0;
        id_ex_read_data2 <= 32'b0;
        id_ex_imm <= 32'b0;
        id_ex_pc_add_4 <= 32'b0;
        id_ex_rd <= 5'b0;
        id_ex_rs1 <= 5'b0;
        id_ex_rs2 <= 5'b0;
    end
    else begin
        id_ex_reg_write <= id_reg_write;
        id_ex_mem_to_reg <= id_mem_to_reg;
        id_ex_mem_write <= id_mem_write;
        id_ex_branch <= id_branch;
        id_ex_alu_src <= id_alu_src;
        id_ex_alu_ctrl <= id_alu_ctrl;
        id_ex_jal <= id_jal;
        id_ex_read_data1 <= id_read_data1;
        id_ex_read_data2 <= id_read_data2;
        id_ex_imm <= id_imm;
        id_ex_pc_add_4 <= id_pc_add_4;
        id_ex_rd <= id_rd;
        id_ex_rs1 <= id_rs1;
        id_ex_rs2 <= id_rs2;
    end
end

// EX STAGE
logic [31:0] ex_result;
logic ex_zero;
logic ex_pc_src;
logic [31:0] ex_branch_target;
logic ex_reg_write;
logic ex_mem_to_reg;
logic ex_mem_write;
logic [4:0] ex_rd;
logic [31:0] ex_write_data;
logic [31:0] ex_pc_add_4;
logic ex_jal;

ex_stage execute(.*);

// EX/MEM pipeline register
logic [31:0] ex_mem_result;
logic ex_mem_reg_write;
logic ex_mem_mem_to_reg;
logic ex_mem_mem_write;
logic [4:0] ex_mem_rd;
logic [31:0] ex_mem_write_data;
logic [31:0] ex_mem_pc_add_4;
logic ex_mem_jal;

always_ff @(posedge clk) begin
    if (reset) begin
        ex_mem_result <= 0;
        ex_mem_pc_add_4 <= 0;
        ex_mem_reg_write <= 0;
        ex_mem_mem_to_reg <= 0;
        ex_mem_mem_write <= 0;
        ex_mem_rd <= 5'b0;
        ex_mem_write_data <= 32'b0;
        ex_mem_jal <= 0;
    end
    else begin
        ex_mem_result <= ex_result;
        ex_mem_pc_add_4 <= ex_pc_add_4;
        ex_mem_reg_write <= ex_reg_write;
        ex_mem_mem_to_reg <= ex_mem_to_reg;
        ex_mem_mem_write <= ex_mem_write;
        ex_mem_rd <= ex_rd;
        ex_mem_write_data <= ex_write_data;
        ex_mem_jal <= ex_jal;
    end
end


//MEM STAGE
logic [31:0] mem_read_data;
logic [31:0] mem_result;
logic [31:0] mem_pc_add_4;
logic [4:0] mem_rd;
logic mem_reg_write;
logic mem_mem_to_reg;
logic mem_jal;

mem_stage memory(.*);


// MEM/WB pipeline register

logic [31:0] mem_wb_read_data;
logic [31:0] mem_wb_result;
logic [31:0] mem_wb_pc_add_4;
logic [4:0] mem_wb_rd;
logic mem_wb_reg_write;
logic mem_wb_mem_to_reg;
logic mem_wb_jal;


always_ff @(posedge clk) begin
    if (reset) begin
        mem_wb_read_data <= 0;
        mem_wb_result <= 0;
        mem_wb_pc_add_4 <= 0;
        mem_wb_rd <= 0;
        mem_wb_reg_write <= 0;
        mem_wb_mem_to_reg <= 0;
        mem_wb_jal <= 0;
    end 

    else begin
        
        mem_wb_read_data <= mem_read_data;
        mem_wb_result <= mem_result;
        mem_wb_pc_add_4 <= mem_pc_add_4;
        mem_wb_rd <= mem_rd;
        mem_wb_reg_write <= mem_reg_write;
        mem_wb_mem_to_reg <= mem_mem_to_reg;
        mem_wb_jal <= mem_jal;




    end

end



endmodule