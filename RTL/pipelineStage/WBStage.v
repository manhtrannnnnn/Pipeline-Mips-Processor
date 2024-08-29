`include "defines.v"

module WBStage(
    input metoreg_wb,
    input [`WIDTH-1:0] readdata_wb, aluout_wb,
    output [`WIDTH-1:0] result_wb
);

    mux2to1 mux_result(aluout_wb, readdata_wb, metoreg_wb, result_wb);

endmodule