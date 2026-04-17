`timescale 1ns/1ps

module tb_top;

//================ SIGNAL =================
reg clk;
reg rst;

// debug outputs t? top
wire [31:0] pc;
wire [31:0] pc4;
wire [31:0] instr;
wire [31:0] alu_out;
wire [31:0] wb_out;
integer cycle;

//================ DUT =================
top uut(
    .clk(clk),
    .rst(rst),

    .pc_out(pc),
    .pc4_out(pc4),
    .instr_out(instr),
    .alu_debug(alu_out),
    .wb_debug(wb_out)
);

//================ CLOCK =================
always #5 clk = ~clk;

//================ INIT =================
initial begin
    clk = 0;
    rst = 1;
    cycle = 0;

    $display("===== RV32I LOAD/STORE BYTE-HALF TEST =====");
    $display("cycle | time | PC | INSTR | ALU | WB | x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11");

    #10 rst = 0;
end

//================ PRINT =================
always @(posedge clk) begin
    cycle = cycle + 1;
    $display("%0d | %0t | %h | %h | %h | %h | %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d",
              cycle, $time, pc, instr, alu_out, wb_out,
              uut.RF.regf[1], uut.RF.regf[2], uut.RF.regf[3], uut.RF.regf[4], uut.RF.regf[5],
              uut.RF.regf[6], uut.RF.regf[7], uut.RF.regf[8], uut.RF.regf[9], uut.RF.regf[10],
              uut.RF.regf[11]);
end

//================ STOP =================
initial begin
    #180;
    $display("===== CHECK RESULT =====");
    if (uut.RF.regf[3]  == 32'd255 &&
        uut.RF.regf[4]  == 32'hFFFF_FFFF &&
        uut.RF.regf[7]  == 32'd13330 &&
        uut.RF.regf[8]  == 32'd13330 &&
        uut.RF.regf[10] == 32'hFFFF_FF80 &&
        uut.RF.regf[11] == 32'd128) begin
        $display("PASS: lb/lh/lbu/lhu and sb/sh are working.");
    end else begin
        $display("FAIL: Unexpected register values.");
        $display("x3=%0d x4=%h x7=%0d x8=%0d x10=%h x11=%0d",
                 uut.RF.regf[3], uut.RF.regf[4], uut.RF.regf[7], uut.RF.regf[8], uut.RF.regf[10], uut.RF.regf[11]);
    end
    $display("===== END SIM =====");
    $finish;
end

endmodule