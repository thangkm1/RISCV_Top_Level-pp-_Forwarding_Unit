module top(
    input clk, rst,

    output [31:0] pc_out,
    output [31:0] pc4_out,
    output [31:0] instr_out,
    output [31:0] alu_debug,
    output [31:0] wb_debug
);

//================ 2-STAGE PIPELINE =================
// Stage 1: IF + ID
// Stage 2: EX + MEM + WB

//---------------- IF ----------------
wire [31:0] pc, pc_next;
wire [31:0] instrD;
wire [31:0] pc_plus4 = pc + 4;

assign pc_out  = pc;
assign pc4_out = pc_plus4;
assign instr_out = instrD;

pc PC(clk, rst, pc_next, pc);
imem IMEM(pc, instrD);

//---------------- ID ----------------
wire [4:0] rs1D = instrD[19:15];
wire [4:0] rs2D = instrD[24:20];
wire [4:0] rdD  = instrD[11:7];

wire regwriteD, memwriteD, alusrcD, memtoregD, branchD;
wire [1:0] mem_sizeD;
wire load_unsignedD;
wire [3:0] alu_selD;
wire [31:0] immD;
wire [31:0] rd1_rawD, rd2_rawD;

control CTRL(
    instrD[6:0], instrD[14:12], instrD[31:25],
    regwriteD, memwriteD, alusrcD, memtoregD, branchD, mem_sizeD, load_unsignedD, alu_selD
);

imm_gen IMM(instrD, immD);

//---------------- E stage visible to D for forwarding ----------------
reg [31:0] opA_E, opB_E, imm_E;
reg [4:0] rd_E;
reg regwrite_E, memwrite_E, alusrc_E, memtoreg_E;
reg [1:0] mem_size_E;
reg load_unsigned_E;
reg [3:0] alu_sel_E;

wire [31:0] wb_dataE;

regfile RF(
    clk,
    regwrite_E,
    rs1D, rs2D,
    rd_E,
    wb_dataE,
    rd1_rawD, rd2_rawD
);

wire [1:0] forwardA, forwardB;
wire [31:0] rd1D, rd2D;
wire [2:0] funct3D = instrD[14:12];
wire [31:0] pc_branch = pc + immD;

wire beq_taken  = (rd1D == rd2D);
wire bne_taken  = (rd1D != rd2D);
wire blt_taken  = ($signed(rd1D) < $signed(rd2D));
wire bge_taken  = ($signed(rd1D) >= $signed(rd2D));
wire bltu_taken = (rd1D < rd2D);
wire bgeu_taken = (rd1D >= rd2D);

wire branch_takenD = branchD && (
    (funct3D == 3'b000 && beq_taken)  ||
    (funct3D == 3'b001 && bne_taken)  ||
    (funct3D == 3'b100 && blt_taken)  ||
    (funct3D == 3'b101 && bge_taken)  ||
    (funct3D == 3'b110 && bltu_taken) ||
    (funct3D == 3'b111 && bgeu_taken)
);

forwarding_unit FWD(
    rs1D, rs2D,
    rd_E,
    regwrite_E,
    forwardA, forwardB
);

assign rd1D = (forwardA == 2'b10) ? wb_dataE : rd1_rawD;
assign rd2D = (forwardB == 2'b10) ? wb_dataE : rd2_rawD;
assign pc_next = branch_takenD ? pc_branch : pc_plus4;

//---------------- Stage 1 -> Stage 2 pipeline registers ----------------
always @(posedge clk or posedge rst) begin
    if (rst) begin
        opA_E <= 32'b0;
        opB_E <= 32'b0;
        imm_E <= 32'b0;
        rd_E <= 5'b0;
        regwrite_E <= 1'b0;
        memwrite_E <= 1'b0;
        alusrc_E <= 1'b0;
        memtoreg_E <= 1'b0;
        mem_size_E <= 2'b10;
        load_unsigned_E <= 1'b0;
        alu_sel_E <= 4'b0;
    end else begin
        opA_E <= rd1D;
        opB_E <= rd2D;
        imm_E <= immD;
        rd_E <= rdD;
        regwrite_E <= regwriteD;
        memwrite_E <= memwriteD;
        alusrc_E <= alusrcD;
        memtoreg_E <= memtoregD;
        mem_size_E <= mem_sizeD;
        load_unsigned_E <= load_unsignedD;
        alu_sel_E <= alu_selD;
    end
end

//---------------- EX/MEM/WB ----------------
wire [31:0] alu_in2_E;
wire [31:0] alu_out_E;
wire [31:0] mem_data_E;

assign alu_in2_E = alusrc_E ? imm_E : opB_E;

alu ALU(opA_E, alu_in2_E, alu_sel_E, alu_out_E);
dmem DMEM(clk, memwrite_E, mem_size_E, load_unsigned_E, alu_out_E, opB_E, mem_data_E);

assign wb_dataE = memtoreg_E ? mem_data_E : alu_out_E;

assign alu_debug = alu_out_E;
assign wb_debug = wb_dataE;

endmodule