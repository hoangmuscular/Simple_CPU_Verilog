`timescale 1ns / 1ps

module Controller(
input wire clk,
input wire rst,
input wire [2:0] opcode,
input wire zero,
output reg sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e 
    );
reg[2:0] current_state, next_state;
localparam INST_ADDR = 3'd0;
localparam INST_FETCH = 3'd1;
localparam INST_LOAD = 3'd2;
localparam IDLE = 3'd3;
localparam OP_ADDR = 3'd4;
localparam OP_FETCH = 3'd5;
localparam ALU_OP = 3'd6;
localparam STORE = 3'd7;

always @(posedge clk) begin
   if(rst) begin
      current_state <= INST_ADDR;
   end else begin
      current_state <= next_state;
   end
end

always @(*) begin
   if (halt) begin
      next_state = current_state;
   end else begin
      next_state = current_state + 1;
   end
end

always @(*) begin
sel = 0; 
rd = 0; 
ld_ir = 0; 
halt = 0; 
inc_pc = 0; 
ld_ac = 0; 
ld_pc = 0; 
wr = 0; 
data_e = 0;
   case(current_state)
      INST_ADDR: sel = 1'b1;
      INST_FETCH: begin
         sel = 1'b1; 
         rd = 1'b1 ;
      end
      INST_LOAD: begin
         sel = 1'b1; 
         rd = 1'b1 ;
         ld_ir = 1'b1;
      end
      IDLE: begin
         sel = 1'b1;
         rd = 1'b1;
         ld_ir = 1'b1;
      end
      OP_ADDR: begin
         halt = (opcode == 3'b000);
         inc_pc = 1'b1;
      end
      OP_FETCH: begin
         rd = (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode ==3'b101);
      end
      ALU_OP: begin
         rd = (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode ==3'b101);
         inc_pc = (opcode == 3'b001 && zero);
         ld_pc = (opcode == 3'b111);
         data_e = (opcode == 3'b110);
      end
      STORE: begin
         rd = (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode ==3'b101);
         ld_ac = (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode ==3'b101);
         ld_pc = (opcode == 3'b111);
         wr = (opcode == 3'b110);
         data_e = (opcode == 3'b110);
      end
      default:; 
   endcase
 end
endmodule
