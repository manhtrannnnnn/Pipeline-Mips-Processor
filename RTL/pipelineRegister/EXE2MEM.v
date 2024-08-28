`include "defines.v"

module EXE2MEM(
    input clk, rst,
    input regwrite_decode, memtoreg_decode, memwrite_decode,
    input [`WIDTH-1:0] aluout,
    input [`WIDTH-1:0] writedata_exe,
    input [4:0] regaddr_exe,
    output reg regwrite_mem, memtoreg_mem, memwrite_mem,
    output reg [`WIDTH-1:0] aluout_mem, 
    output reg [`WIDTH-1:0] writedata_mem,
    output reg [4:0] regaddr_mem
);
    always@(posedge clk) begin
        if(!rst) begin
            {regwrite_mem, memtoreg_mem, memwrite_mem, aluout_mem, writedata_mem, regaddr_mem} <= 6'b0;
        end
        else begin
            {regwrite_mem, memtoreg_mem, memwrite_mem, aluout_mem, writedata_mem, regaddr_mem} <= {regwrite_decode, memtoreg_decode, memwrite_decode, aluout, writedata_exe, regaddr_exe};
        end
    end


endmodule