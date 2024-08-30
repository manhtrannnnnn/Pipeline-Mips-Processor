`include "defines.v"

module ID2EXE(
    input clk, rst,
    input flush_exe,
    input regwrite_decode, memtoreg_decode, memwrite_decode,
    input alusrc_decode, regdst_decode,
    input [3:0] alucontrol_decode,
    input [`WIDTH-1:0] data1_decode, data2_decode,
    input [4:0] Rs_decode, Rt_decode, Rd_decode,
    input [`WIDTH-1:0] signext_decode, shamt_decode,
    output regwrite_exe, memtoreg_exe, memwrite_exe, alusrc_exe, regdst_exe,
    output [3:0] alucontrol_exe,
    output [`WIDTH-1:0] data1_exe, data2_exe,
    output [4:0] Rs_exe, Rt_exe, Rd_exe,
    output [`WIDTH-1:0] signext_exe, shamt_exe
);
    always @(posedge clk) begin
        if(!rst or flush_exe) begin
            {regwrite_exe, memtoreg_exe, memwrite_exe, alusrc_exe, regdst_exe, alucontrol_exe, data1_exe, data2_exe, Rs_exe, Rt_exe, Rd_exe, signext_exe, shamt_exe} <= 12'b0;
        end
        else begin
            {regwrite_exe, memtoreg_exe, memwrite_exe, alusrc_exe, regdst_exe, alucontrol_exe, data1_exe, data2_exe, Rs_exe, Rt_exe, Rd_exe, signext_exe, shamt_exe} <= {regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, alucontrol_decode, data1_decode, data2_decode, Rs_decode, Rt_decode, Rd_decode, signext_decode, shamt_decode};
        end
    end
endmodule