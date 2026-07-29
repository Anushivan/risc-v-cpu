module hazard_unit(
    input logic [4:0] id_ex_rd,
    input logic [4:0] id_rs1,
    input logic [4:0] id_rs2,
    input logic id_ex_mem_to_reg,
    output logic stall
);

always_comb begin 
    
    if (id_ex_mem_to_reg == 1) begin
        if (id_ex_rd == id_rs1 || id_ex_rd == id_rs2) begin
            stall = 1;
            end
        else begin
            stall = 0;
        end
        end
    
    else begin
        stall = 0;
    end
end
endmodule