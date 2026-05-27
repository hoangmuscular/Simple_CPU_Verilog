module accumulator (
    input clk,
    input rst,
    input ld_ac,
    input [31:0] data_in, 
    output reg [31:0] ac_out 
);

    always @(posedge clk) begin
   if(rst) begin
      ac_out <= 8'd0;
   end else begin
      if (ld_ac) begin
         ac_out <= data_in;
      end
   end
end

endmodule
