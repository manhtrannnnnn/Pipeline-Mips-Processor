`include "defines.v"

module IFStage(
    input clk, rst, 
    input jump_decode, pcsrc_decode, flush_decode ,stall_pc,
    input [`WIDTH-1:0] pc_branch, pc_jump, 
    output wire [`WIDTH-1:0] instr_fetch, pc_fetch
);
    wire [`WIDTH-1:0] pc_in, pc_out1, pc_out;

    //Program Counter
    pc pc(clk,rst,stall_pc, pc_in, pc_out);
    
    //adder
    adder adder(pc_out, `WIDTH'b100, pc_fetch);

    //Select Mux
    mux2to1 select_branch(pc_fetch, pc_branch, pcsrc_decode, pc_out1);
    mux2to1 select_jump(pc_out1, pc_jump, jump_decode, pc_in);

    //Instruction Memory
    IMEM imem(pc_out, instr_fetch);

endmodule