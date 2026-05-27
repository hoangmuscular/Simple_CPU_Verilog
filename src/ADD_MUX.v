module address_mux #(
    parameter WIDTH = 32 
)(
    input [WIDTH-1:0] pc_addr, 
    input [WIDTH-1:0] ir_addr,
    input sel, 
    output [WIDTH-1:0] addr_out 
);
    assign add_out = (sel) ? pc_add : ir_add;
endmodule
