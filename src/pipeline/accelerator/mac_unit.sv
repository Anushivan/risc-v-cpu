module mac_unit(
    input logic clk,
    input logic clear,
    input logic enable,
    input logic [31:0] a,
    input logic [31:0] b,
    output logic [31:0] result
);

logic [63:0] acc;

assign result = acc [31:0];


always_ff @(posedge clk) begin
    

    if (clear) begin
        acc <= 0;
    end
    else if (enable)begin
        acc <= acc + $signed(a) * $signed(b);
    end
    
end




endmodule