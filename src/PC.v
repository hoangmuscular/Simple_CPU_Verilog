module PC(
    input clk,
    input rst,
    input ld_pc,
    input inc_pc,
    input [31:0] data_in,
    output reg [31:0] pc_out
    );
    always @( posedge clk) begin
   if (rst)
      pc_out <= 4'd0;
   else if (ld_pc)
      pc_out <= data_in;
   else if (inc_pc)
      pc_out <= pc_out + 1;      
end
endmodule
