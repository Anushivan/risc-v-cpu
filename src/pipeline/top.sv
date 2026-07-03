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


//IF STAGE
logic [31:0] pc_add_4, instruction;
if_stage ifstg(.*);

// IF/ID pipeline register
logic [31:0] if_id_instruction;
logic [31:0] if_id_pc_add_4;

always_ff @(posedge clk) begin
    if (reset) begin
        if_id_instruction <= 32'b0;
        if_id_pc_add_4    <= 32'b0;
    end
    else begin
        if_id_instruction <= instruction;
        if_id_pc_add_4    <= pc_padd_4;
    end
end

// IF/ID pipeline register







endmodule