module id_ex(input clk,
    input [31:0] rd1, rd2, imm,
    input [4:0] rs1, rs2, rd,
    input [3:0] alu_sel,
    input alusrc, regwrite, memwrite, memtoreg,

    output reg [31:0] rd1_o, rd2_o, imm_o,
    output reg [4:0] rs1_o, rs2_o, rd_o,
    output reg [3:0] alu_sel_o,
    output reg alusrc_o, regwrite_o, memwrite_o, memtoreg_o
);

always @(posedge clk) begin
    rd1_o<=rd1; rd2_o<=rd2; imm_o<=imm;
    rs1_o<=rs1; rs2_o<=rs2; rd_o<=rd;

    alu_sel_o<=alu_sel;
    alusrc_o<=alusrc;
    regwrite_o<=regwrite;
    memwrite_o<=memwrite;
    memtoreg_o<=memtoreg;
end

endmodule