`include "defines.v"

module MEMStage(
    input clk,
    input memwrite_mem, 
    input [`WIDTH-1:0] aluout_mem, writedata_mem,
    output [`WIDTH-1:0] readdata_mem
);

    DMEM dmem(clk, memwrite_mem, aluout_mem, writedata_mem, readdata_mem);

endmodule