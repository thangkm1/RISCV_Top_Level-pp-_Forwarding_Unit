module ex_mem(input clk,
    input [31:0] alu_in, wd_in,
    input [4:0] rd_in,
    input regwrite_in, memwrite_in, memtoreg_in,

    output reg [31:0] alu_out, wd_out,
    output reg [4:0] rd_out,
    output reg regwrite_out, memwrite_out, memtoreg_out
);

always @(posedge clk) begin
    alu_out<=alu_in;
    wd_out<=wd_in;
    rd_out<=rd_in;

    regwrite_out<=regwrite_in;
    memwrite_out<=memwrite_in;
    memtoreg_out<=memtoreg_in;
end

endmodule