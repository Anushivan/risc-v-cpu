module if_stage(
    input  logic [31:0] pc,
    input  logic [31:0] pc_next,
    output logic [31:0] if_instruction,
    output logic [31:0] if_pc_add_4
);

assign if_pc_add_4 = pc + 4;

instruction_memory imem(
    .address(pc),
    .instruction(if_instruction) 
    );

endmodule