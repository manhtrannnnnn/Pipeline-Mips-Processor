`include "defines.v"

module signExtend(
    input [15:0] data_in,
    output [`WIDTH-1:0] data_out
);
    assign data_out = {16{data_in[15]}, data_in};
endmodule
