module CPU (
    input clk, 
    input rst,  
    output halt 
);

    wire sel, rd, ld_ir, inc_pc, ld_ac, ld_pc, wr, data_e;
    wire [2:0] opcode;
    wire [4:0] operand; 
    wire [4:0] pc_addr; 
    wire [4:0] mux_addr;
    wire zero;
    wire [7:0] alu_out;
    wire [7:0] ac_out;
    wire [7:0] data_bus;


    Controller ctrl_unit (
        .clk(clk), .rst(rst), .opcode(opcode), .zero(zero),
        .sel(sel), .rd(rd), .ld_ir(ld_ir), .halt(halt), 
        .inc_pc(inc_pc), .ld_ac(ld_ac), .ld_pc(ld_pc), .wr(wr), .data_e(data_e)
    );

    ProgramCounter pc_unit (
        .clk(clk), .rst(rst), .inc_pc(inc_pc), .ld_pc(ld_pc),
        .data_in(operand), 
        .pc_out(pc_addr)
    );

    AddressMux mux_unit (
        .sel(sel),
        .pc_add(pc_addr),
        .ir_add(operand),
        .add_out(mux_addr)
    );

    Memory mem_unit (
        .clk(clk), .rd(rd), .wr(wr),
        .addr(mux_addr), 
        .data(data_bus)
    );

    InstructionRegister ir_unit (
        .clk(clk), .rst(rst), .ld_ir(ld_ir),
        .data_in(data_bus), 
        .opcode(opcode),
        .operand(operand)
    );

    ALU alu_unit (
        .opcode(opcode),
        .inB(data_bus),    
        .inA(ac_out),      
        .zero(zero),
        .alu_out(alu_out)
    );

    Accumulator ac_unit (
        .clk(clk), .rst(rst), .ld_ac(ld_ac),
        .data_in(alu_out), 
        .ac_out(ac_out)
    );
    assign data_bus = (data_e) ? ac_out : 8'bz;

endmodule
