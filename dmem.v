module dmem(
    input clk, we,
    input [1:0] mem_size,      // 00:byte, 01:half, 10:word
    input load_unsigned,       // 1 for zero-extend byte/half loads
    input [31:0] addr, wd,
    output reg [31:0] rd
);

reg [7:0] mem[0:1023];

wire [31:0] base = {addr[31:2], 2'b00};
wire [7:0] b0 = mem[base];
wire [7:0] b1 = mem[base + 1];
wire [7:0] b2 = mem[base + 2];
wire [7:0] b3 = mem[base + 3];
wire [31:0] word_data = {b3, b2, b1, b0};
wire [15:0] half_data = addr[1] ? word_data[31:16] : word_data[15:0];
wire [7:0] byte_data = (addr[1:0] == 2'b00) ? word_data[7:0] :
                       (addr[1:0] == 2'b01) ? word_data[15:8] :
                       (addr[1:0] == 2'b10) ? word_data[23:16] :
                                               word_data[31:24];

always @(*) begin
    case(mem_size)
        2'b00: rd = load_unsigned ? {24'b0, byte_data} : {{24{byte_data[7]}}, byte_data};
        2'b01: rd = load_unsigned ? {16'b0, half_data} : {{16{half_data[15]}}, half_data};
        default: rd = word_data;
    endcase
end

always @(posedge clk) begin
    if (we) begin
        case(mem_size)
            2'b00: begin // SB
                case(addr[1:0])
                    2'b00: mem[base]     <= wd[7:0];
                    2'b01: mem[base + 1] <= wd[7:0];
                    2'b10: mem[base + 2] <= wd[7:0];
                    2'b11: mem[base + 3] <= wd[7:0];
                endcase
            end
            2'b01: begin // SH
                if (addr[1] == 1'b0) begin
                    mem[base]     <= wd[7:0];
                    mem[base + 1] <= wd[15:8];
                end else begin
                    mem[base + 2] <= wd[7:0];
                    mem[base + 3] <= wd[15:8];
                end
            end
            default: begin // SW
                mem[base]     <= wd[7:0];
                mem[base + 1] <= wd[15:8];
                mem[base + 2] <= wd[23:16];
                mem[base + 3] <= wd[31:24];
            end
        endcase
    end
end

endmodule