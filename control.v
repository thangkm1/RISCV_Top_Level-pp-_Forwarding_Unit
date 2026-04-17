module control(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg regwrite,
    output reg memwrite,
    output reg alusrc,
    output reg memtoreg,
    output reg branch,
    output reg [1:0] mem_size,     // 00: byte, 01: half, 10: word
    output reg load_unsigned,      // 1 for LBU/LHU
    output reg [3:0] alu_sel
);

always @(*) begin
    // default
    regwrite=0; memwrite=0; alusrc=0; memtoreg=0; branch=0;
    mem_size=2'b10; load_unsigned=0; alu_sel=0;

    case(opcode)

        // R-type
        7'b0110011: begin
            regwrite=1;
            alusrc=0;

            case({funct7,funct3})
                {7'b0000000,3'b000}: alu_sel=4'b0000; // ADD
                {7'b0100000,3'b000}: alu_sel=4'b0001; // SUB
                {7'b0000000,3'b111}: alu_sel=4'b0010; // AND
                {7'b0000000,3'b110}: alu_sel=4'b0011; // OR
                {7'b0000000,3'b100}: alu_sel=4'b0100; // XOR
                {7'b0000000,3'b001}: alu_sel=4'b0101; // SLL
                {7'b0000000,3'b101}: alu_sel=4'b0110; // SRL
                {7'b0100000,3'b101}: alu_sel=4'b0111; // SRA
                {7'b0000000,3'b010}: alu_sel=4'b1000; // SLT
                {7'b0000000,3'b011}: alu_sel=4'b1001; // SLTU
            endcase
        end

        // I-type ALU
        7'b0010011: begin
            regwrite=1;
            alusrc=1;
            case(funct3)
                3'b000: alu_sel=4'b0000; // ADDI
                3'b111: alu_sel=4'b0010; // ANDI
                3'b110: alu_sel=4'b0011; // ORI
                3'b100: alu_sel=4'b0100; // XORI
                3'b001: alu_sel=4'b0101; // SLLI
                3'b101: alu_sel=(funct7==7'b0100000) ? 4'b0111 : 4'b0110; // SRAI/SRLI
                3'b010: alu_sel=4'b1000; // SLTI
                3'b011: alu_sel=4'b1001; // SLTIU
                default: alu_sel=4'b0000;
            endcase
        end

        // LOAD: LB/LH/LW/LBU/LHU
        7'b0000011: begin
            regwrite=1;
            alusrc=1;
            memtoreg=1;
            alu_sel=4'b0000; // address calc
            case(funct3)
                3'b000: begin mem_size=2'b00; load_unsigned=0; end // LB
                3'b001: begin mem_size=2'b01; load_unsigned=0; end // LH
                3'b010: begin mem_size=2'b10; load_unsigned=0; end // LW
                3'b100: begin mem_size=2'b00; load_unsigned=1; end // LBU
                3'b101: begin mem_size=2'b01; load_unsigned=1; end // LHU
                default: begin mem_size=2'b10; load_unsigned=0; end
            endcase
        end

        // STORE: SB/SH/SW
        7'b0100011: begin
            memwrite=1;
            alusrc=1;
            alu_sel=4'b0000; // address calc
            case(funct3)
                3'b000: mem_size=2'b00; // SB
                3'b001: mem_size=2'b01; // SH
                3'b010: mem_size=2'b10; // SW
                default: mem_size=2'b10;
            endcase
        end

        // Branch (compare handled in top)
        7'b1100011: begin
            branch=1;
            alusrc=0;
        end

    endcase
end

endmodule