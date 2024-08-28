`include "defines.v"

module pc(
    input clk, rst,
    input stall_pc,
    input [`WIDTH-1:0] pc_in,
    output reg [`WIDTH-1:0] pc_out
);
    always @(posedge clk) begin
        if (!rst) begin
            pc_out <= 0;
        end else if (stall_pc) begin
            pc_out <= pc_out;
        end else begin
            pc_out <= pc_in;
        end
    end

endmodule