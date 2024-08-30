`include "defines.v"

module IF2ID(
    input clk, rst,
    input stall_decode, flush_decode,
    input [`WIDTH-1:0] pc_fetch,
    input [`WIDTH-1:0] instr_fetch,
    output [`WIDTH-1:0] pc_decode,
    output [`WIDTH-1:0] instr_decode
);

    always @(posedge clk) begin
        if(~rst || flush_decode) begin
            {pc_decode, instr_decode} <= 2'b0;
        end
        else if(stall_decode) begin
            {pc_decode, instr_decode} <= {pc_decode, instr_decode};
        end
        else begin
            {pc_decode, instr_decode} <= {pc_fetch, instr_fetch};
        end
    end

endmodule