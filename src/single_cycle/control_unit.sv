module control_unit(
input logic [31:0] instruction,
output logic reg_write,
output logic [2:0] alu_ctrl,
output logic data_mem_write,
output logic branch,
output logic mem_to_reg,
output logic alu_src,
output logic jal
);


always @(*)  begin

case(instruction[6:0]) 


//R-TYPE
7'b0110011: begin
   reg_write = 1;
   case(instruction[14:12])
    3'b000: alu_ctrl = instruction[30] ? 3'b001 : 3'b000;
    3'b010: alu_ctrl = 3'b101;
    3'b100: alu_ctrl = 3'b100;
    3'b110: alu_ctrl = 3'b011;
    3'b111: alu_ctrl = 3'b010;
    default: alu_ctrl = 3'b000;
   endcase 
   data_mem_write = 0;
   branch = 0;
   mem_to_reg = 0;
   alu_src = 0;
   jal = 0;
end
// LW (data memory load)
7'b0000011:begin
   reg_write = 1;
   alu_ctrl = 3'b000;
   data_mem_write = 0;
   branch = 0;
   mem_to_reg = 1;
   alu_src = 1;
   jal = 0;
end

// SW (data memory store) 
7'b0100011: begin
   
   reg_write = 0;
   alu_ctrl = 3'b000;
   data_mem_write = 1;
   branch = 0;
   mem_to_reg = 0;
   alu_src = 1;
   jal = 0;
end

//Branch
7'b1100011: begin
   reg_write = 0;
   alu_ctrl = 3'b001;
   data_mem_write = 0;
   branch = 1;
   mem_to_reg = 0;
   alu_src = 0;
   jal = 0;
end

//ADDI
7'b0010011: begin
   reg_write = 1;
   case(instruction[14:12])
    3'b000: alu_ctrl = 3'b000;
    3'b010: alu_ctrl = 3'b101;
    3'b100: alu_ctrl = 3'b100;
    3'b110: alu_ctrl = 3'b011;
    3'b111: alu_ctrl = 3'b010;
    default: alu_ctrl = 3'b000;
   endcase 
   data_mem_write = 0;
   branch = 0;
   mem_to_reg = 0;
   alu_src = 1;
   jal = 0;
end

//jal
7'b1101111:begin
   reg_write = 1;
   alu_ctrl = 3'b000;
   data_mem_write = 0;
   branch = 0;
   mem_to_reg = 0;
   alu_src = 1;
   jal = 1;
end



default: begin
    reg_write = 0;
    alu_ctrl = 3'b000;
    data_mem_write = 0;
    branch = 0;
    mem_to_reg = 0;
    alu_src = 0;
end


endcase



    
end



endmodule