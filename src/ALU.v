module alu (
    input [31:0] inA,
    input [31:0] inB, 
    input [2:0] opcode,  
    output reg [31:0] alu_out,
    output zero 
);
    assign zero = (inA == 8'b00000000) ? 1'b1 : 1'b0;
always @(*) begin
   case (opcode)
            3'b000: alu_out = inA;         // HLT
            3'b001: alu_out = inA;         // SKZ
            3'b010: alu_out = inA + inB;   // ADD
            3'b011: alu_out = inA & inB;   // AND
            3'b100: alu_out = inA ^ inB;   // XOR
            3'b101: alu_out = inB;         // LDA
            3'b110: alu_out = inA;         // STO
            3'b111: alu_out = inA;         // JMP
            default: alu_out = 8'd0;     
        endcase
end

endmodule
