`include "defines.v"

module EXEStage(
    input alusrc_exe, regdst_exe,
    input [3:0] alucontrol_exe,
    input [`WIDTH-1:0] data1_exe, data2_exe,
    input [4:0] Rt_exe, Rd_exe, shamt_exe,
    input [`WIDTH-1:0] signext_exe,
    input [1:0] forwardA_exe, forwardB_exe,
    input [`WIDTH-1:0] aluout_mem, result_wb,
    output [`WIDTH-1:0] aluout_exe, writedata_exe, 
    output [4:0] regaddr_exe
);
    wire [`WIDTH-1:0] val1 ,val2;
    // ALU
    mux4to1 mux_val1(data1_exe, result_wb, aluout_mem, 32'b0, forwardA_exe, val1);
    mux4to1 mux_writedata(data2_exe, result_wb, aluout_mem, 32'b0, forwardB_exe, writedata_exe);
    mux2to1 mux_val2(writedata_exe, signext_exe, alusrc_exe, val2);
    ALU alu(val1, val2, shamt_exe, alucontrol_exe, aluout_exe);

    // Reg Address
    mux2to1 mux_regaddr(Rt_exe, Rd_exe, regdst_exe, regaddr_exe);
endmodule