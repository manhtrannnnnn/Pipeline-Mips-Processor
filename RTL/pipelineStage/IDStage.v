`include "defines.v"

module IDStage(
    input clk, rst,
    input [`WIDTH-1:0] instr_decode,
    input [`WIDTH-1:0] pc_decode,
    input [4:0] regaddr_wb, 
    input [`WIDTH-1:0] result_wb,
    input forwardA_decode, forwardB_decode,
    input [`WIDTH-1:0] aluout_mem,
    output [`WIDTH-1:0] pc_branch, pc_jump,
    output [4:0] Rs_decode, Rt_decode, Rd_decode, shamt_decode
    output [`WIDTH-1:0] signext_decode,
    output reg [`WIDTH-1:0] data1, data2,
    output reg regwrite_decode, memtoreg_decode, memwrite_decode, alucontrol_decode, alusrc_decode,
    output reg [3:0] alucontrol_decode,
    output pcsrc, flush_decode, jump_decode,

);

    reg [1:0] branch_condition;
    reg branch_decode;
    reg branch_src;
    wire [`WIDTH-1:0] datain1, datain2;
    assign Rs_decode = instr_decode[25:21];
    assign Rt_decode = instr_decode[20:16];
    assign Rd_decode = instr_decode[15:11];

    //Control Unit
    control c(instr_decode[31:26], instr_decode[5:0], regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, jump_decode, branch_decode, branch_condition, alucontrol_decode);
    //Register File
    REG rf(clk, rst, Rs_decode, Rt_decode, regaddr_wb, regwrite_wb, result_wb, data1, data2);

    //Sign Extend
    signEntend se(instr_decode[15:0], signext_decode);

    //pc branch
    adder adder(pc_decode, {signext_decode, 2'b00}, pc_branch);

    //pc jump
    assign pcjump = {pc_decode[31:28], instr_decode, 2'b00};

    //Condition Check
    mux2to1 mux1(data1, aluout_mem, forwardA_decode, datain1);
    mux2to1 mux2(data2, aluout_mem, forwardB_decode, datain2);
    condition_check cc(datain1, datain2, branch_condition, branch_src);

    //Branch Source
    assign pcsrc = branch_src & branch_decode;
    assign flush_decode = branch_src | jump_decode;
endmodule