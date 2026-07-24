module forwarding_unit(
    input logic [4:0] id_ex_rs1,
    input logic [4:0] id_ex_rs2,
    input logic [4:0] ex_mem_rd,
    input logic ex_mem_reg_write,
    input logic [4:0] mem_wb_rd,
    input logic mem_wb_reg_write,
    output logic [1:0] forward1,
    output logic [1:0] forward2
);


always_comb begin 
    

if (id_ex_rs1 == ex_mem_rd && ex_mem_reg_write && ex_mem_rd != 5'b0) begin
    forward1 = 2'b10;
end 

    else if(id_ex_rs1 == mem_wb_rd && mem_wb_reg_write && mem_wb_rd != 5'b0)begin
        forward1 = 2'b01;
    end

    else begin
        forward1 = 2'b00;
    end

if (id_ex_rs2 == ex_mem_rd && ex_mem_reg_write && ex_mem_rd != 5'b0) begin
    forward2 = 2'b10;
end 

    else if(id_ex_rs2 == mem_wb_rd && mem_wb_reg_write && mem_wb_rd != 5'b0)begin
        forward2 = 2'b01;
    end

    else begin
        forward2 = 2'b00;
    end

end



endmodule