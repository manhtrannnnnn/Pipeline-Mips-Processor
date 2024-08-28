`include "defines.v"

module MEM2WB(
    input clk, rst,
    input regwrite_mem, memtoreg_mem,
    input [`WIDTH-1:0] aluout_mem, readdata_mem,
    input [`WIDTH-1:0] regaddr_mem,
    output reg regwrite_wb, memtoreg_wb,
    output [`WIDTH-1:0] aluout_wb, readdata_wb,
    output [4:0] regaddr_wb
);
    always@(posedge clk) begin
        if(!rst) begin
            {regwrite_wb, memtoreg_wb, aluout_wb, readdata_wb, regaddr_wb} <= 6'b0;
        end
        else begin
            {regwrite_wb, memtoreg_wb, aluout_wb, readdata_wb, regaddr_wb} <= {regwrite_mem, memtoreg_mem, aluout_mem, readdata_mem, regaddr_mem};
        end
    end
endmodule