module if_stage(
    input  logic [31:0] pc,
    input  logic [31:0] pc_next,
    output logic [31:0] instruction,
    output logic [31:0] pc_add_4
);

assign pc_plus4 = pc + 4;

instruction_memory imem(
    .address(pc),
    .instruction(instruction) 
    );

endmodule