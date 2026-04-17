module forwarding_unit(
    input [4:0] rs1, rs2,
    input [4:0] rdE,
    input regwriteE,
    output reg [1:0] forwardA, forwardB
);

always @(*) begin
    forwardA = 2'b00;
    forwardB = 2'b00;

    if (regwriteE && rdE!=0 && rdE==rs1)
        forwardA = 2'b10;

    if (regwriteE && rdE!=0 && rdE==rs2)
        forwardB = 2'b10;
end

endmodule