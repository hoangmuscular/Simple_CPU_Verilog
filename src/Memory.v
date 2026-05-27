module memory (
    input clk,
    input rd,
    input wr,
    input [31:0] addr, 
    inout [31:0] data  
);

    reg [7:0] mem_array [0:31];
    reg [7:0] data_out;
    always @(posedge clk) begin
        if (wr) begin
            mem_array[addr] <= data; 
        end
        if (rd) begin
            data_out <= mem_array[addr]; 
        end
    end
    assign data = (rd && !wr) ? data_out : 8'bzzzzzzzz;

endmodule
