`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"


module DMEM(
    input clk,
    input memwrite,
    input [`WIDTH-1:0] address, data_in,
    output wire [`WIDTH-1:0] readdata
);
    reg [`WIDTH-1:0] mem[`WIDTH:0];
    always @(posedge clk) begin
        if(memwrite) begin
            mem[address[`WIDTH-1:2]] <= data_in;
        end
    end 

    assign readdata = mem[address[`WIDTH-1:2]];
endmodule