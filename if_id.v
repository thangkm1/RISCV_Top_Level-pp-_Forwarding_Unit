module if_id(input clk,
    input [31:0] pc_in, instr_in,
    output reg [31:0] pc_out, instr_out);

always @(posedge clk) begin
    pc_out <= pc_in;
    instr_out <= instr_in;
end

endmodule