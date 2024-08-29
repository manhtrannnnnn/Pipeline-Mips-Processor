`include "defines.v"

module IDStage(
    input clk, rst,
    input [`WIDTH-1:0] instr_decode, pc_decode,
    input forwardA_decode, forwardB_decode, regwrite_wb,
    input [4:0] regaddr_wb,
    input [`WIDTH-1:0] result_wb, aluout_mem,
    output pcsrc, flush_decode, jump_decode, branch_decode,
    output regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode,
    output reg [3:0] alucontrol_decode,
    output [`WIDTH-1:0] data1, data2,
    output [4:0] Rs_decode, Rt_decode, Rd_decode, shamt_decode,
    output [`WIDTH-1:0] signext_decode, pc_branch, pc_jump
);

    reg [1:0] branch_condition;
    reg branch_check;
    wire [`WIDTH-1:0] data_in1, data_in2;

    assign Rs_decode = instr_decode[25:21];
    assign Rt_decode = instr_decode[20:16];
    assign Rd_decode = instr_decode[15:11];
    assign shamt_decode = instr_decode[10:6];   
    assign signext_decode = {{16{instr_decode[15]}}, instr_decode[15:0]}; // Sign extension
    assign pcsrc = branch_decode & branch_check;
    assign flush_decode = pcsrc | jump_decode;

    //Control Unit
    control c(instr_decode[31:26], instr_decode[5:0], regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, jump_decode, branch_decode, branch_condition, alucontrol_decode);

    //Register File
    REG reg(clk, rst, Rs_decode, Rt_decode, regaddr_wb, regwrite_wb, result_wb, data1, data2);

    //PC Branch
    adder adder_branch(pc_decode, {signext_decode[WIDTH-3:0],2'b0}, pc_branch);

    //PC Jump
    assign pc_jump = {pc_decode[31:28], instr_decode[25:0], 2'b00};  // Jump address calculation 

    //Condition Check
    mux2to1 mux_data1(data1, aluout_mem, forwardA_decode, data_in1);
    mux2to1 mux_data2(data2, aluout_mem, forwardB_decode, data_in2);
    condition_check cc(data_in1, data_in2, branch_condition, branch_check);
endmodule