`include "defines.v"

module IDStage(
    input clk, rst,
    input [`WIDTH-1:0] instr_decode, pc_decode, result_wb,
    input [4:0] regaddr_wb,
    input forwardA_decode, forwardB_decode,
    input regwrite_wb,
    output regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, jump_decode, branch_decode,
    output [3:0] alucontrol_decode,
    output pcsrc_decode, flush_decode,
    output [`WIDTH-1:0] pc_branch, pc_jump,
    output [`WIDTH-1:0] data1_decode, data2_decode
);

    wire [1:0] branch_condition;
    wire branch_check;
    wire [`WIDTH-1:0] data_in1, data_in2;
    wire [`WIDTH-1:0] signext_decode;

    assign flush_decode = pcsrc_decode | jump_decode;
    assign pcsrc_decode = branch_decode & branch_check;
    //Control Unit
    control c(instr_decode[31:26], instr_decode[5:0], regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, jump_decode, branch_decode, branch_condition, alucontrol_decode);

    //Condition Check
    mux2to1 mux_data1(data1_decode, result_wb, forwardA_decode, data_in1);
    mux2to1 mux_data2(data2_decode, result_wb, forwardB_decode, data_in2);
    condition_check compare(data_in1, data_in2, branch_condition, branch_check);

    //Register File
    REG reg(clk, rst, instr_decode[25:21], instr_decode[20:16], regaddr_wb, regwrite_wb, result_wb, data1_decode, data2_decode);

    //PC Branch
    assign signext_decode = {{16{instr_decode[15]}}, instr_decode[15:0]}; // Sign Extend
    adder adder_branch(pc_decode, {signext_decode[WIDTH-3:0],2'b0}, pc_branch);

    //PC Jump
    assign pc_jump = {pc_decode[31:28], instr_decode[25:0], 2'b00};

endmodule