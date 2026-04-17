module mem_wb(input clk,
    input [31:0] alu_in, mem_in,
    input [4:0] rd_in,
    input regwrite_in, memtoreg_in,

    output reg [31:0] alu_out, mem_out,
    output reg [4:0] rd_out,
    output reg regwrite_out, memtoreg_out
);

always @(posedge clk) begin
    alu_out<=alu_in;
    mem_out<=mem_in;
    rd_out<=rd_in;

    regwrite_out<=regwrite_in;
    memtoreg_out<=memtoreg_in;
end

endmodule