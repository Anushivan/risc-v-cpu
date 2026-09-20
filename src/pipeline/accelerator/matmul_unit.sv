module matmul_unit(
    input logic clk,
    input logic reset,
    input logic [31:0] address,
    input logic [31:0] write_data,
    input logic we,
    output logic [31:0] read_data
);

logic [31:0] matrix_A [0:15];
logic [31:0] matrix_B [0:15];
logic [31:0] matrix_C [0:15];

// FSM state: 0=IDLE, 1=CLEAR, 2=COMPUTE, 3=LATCH
logic [1:0] state, next_state;
logic [1:0] k;
logic busy, done_flag;

logic mac_clear, mac_enable;
assign mac_clear = (state == 2'd1);
assign mac_enable = (state == 2'd2);

logic [31:0] mac_a [0:15];
logic [31:0] mac_b [0:15];
logic [31:0] mac_result [0:15];

genvar mac_idx;
generate
    for (mac_idx = 0; mac_idx < 16; mac_idx++) begin
        mac_unit u_mac (
            .clk(clk),
            .clear(mac_clear),
            .enable(mac_enable),
            .a(mac_a[mac_idx]),
            .b(mac_b[mac_idx]),
            .result(mac_result[mac_idx])
        );
    end
endgenerate

always_comb begin
    for (int r = 0; r < 4; r++) begin
        for (int c = 0; c < 4; c++) begin
            mac_a[r*4+c] = matrix_A[r*4 + k];
            mac_b[r*4+c] = matrix_B[k*4 + c];
        end
    end
end

always_ff @(posedge clk) begin
    if (reset) state <= 2'd0;
    else state <= next_state;
end

always_comb begin
    next_state = state;
    case (state)
        2'd0: if (we && address == 32'h10C0 && write_data[0])
                  next_state = 2'd1;
        2'd1: next_state = 2'd2;
        2'd2: if (k == 2'd3) next_state = 2'd3;
        2'd3: next_state = 2'd0;
        default: next_state = 2'd0;
    endcase
end

always_ff @(posedge clk) begin
    if (reset) begin
        k <= 2'd0;
        busy <= 1'b0;
        done_flag <= 1'b0;
    end else begin
        case (state)
            2'd0: begin
                if (we && address == 32'h10C0 && write_data[0]) begin
                    busy <= 1'b1;
                    done_flag <= 1'b0;
                    k <= 2'd0;
                end
            end
            2'd2: k <= k + 2'd1;
            2'd3: begin
                busy <= 1'b0;
                done_flag <= 1'b1;
            end
            default: ;
        endcase
    end
end

always_ff @(posedge clk) begin
    if (state == 2'd3) begin
        for (int idx = 0; idx < 16; idx++)
            matrix_C[idx] <= mac_result[idx];
    end
end

always_ff @(posedge clk) begin
    if (we) begin
        if (address >= 32'h1000 && address < 32'h1040) begin
            matrix_A[(address - 32'h1000) >> 2] <= write_data;
        end
        else if (address >= 32'h1040 && address < 32'h1080) begin
            matrix_B[(address - 32'h1040) >> 2] <= write_data;
        end
    end
end

always_comb begin
    if (address >= 32'h1000 && address < 32'h1040) begin
        read_data = matrix_A[(address - 32'h1000) >> 2];
    end
    else if (address >= 32'h1040 && address < 32'h1080) begin
        read_data = matrix_B[(address - 32'h1040) >> 2];
    end
    else if (address >= 32'h1080 && address < 32'h10C0) begin
        read_data = matrix_C[(address - 32'h1080) >> 2];
    end
    else if (address == 32'h10C4) begin
        read_data = {30'b0, done_flag, busy};
    end
    else begin
        read_data = 32'b0;
    end
end

endmodule