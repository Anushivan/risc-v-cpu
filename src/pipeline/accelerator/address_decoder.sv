module address_decoder(
    input logic [31:0] address,
    input logic [31:0] write_data,
    input logic we,
    input logic [31:0] data_mem_read_data,
    input logic [31:0] matmul_read_data,
    output logic [31:0] data_mem_address,
    output logic [31:0] data_mem_write_data,
    output logic data_mem_we,
    output logic [31:0] matmul_address,
    output logic [31:0] matmul_write_data,
    output logic matmul_we,
    output logic [31:0] read_data
);

always_comb begin 
    

if (address >= 32'h1000) begin
    matmul_address = address;
    matmul_write_data = write_data;
    matmul_we = we;
    read_data = matmul_read_data;
    data_mem_address = 32'b0;
    data_mem_write_data = 32'b0;
    data_mem_we = 0;
end

else begin
    matmul_address = 0;
    matmul_write_data = 0;
    matmul_we = 0;
    read_data = data_mem_read_data;
    data_mem_address = address;
    data_mem_write_data = write_data;
    data_mem_we = we;
end

end


endmodule