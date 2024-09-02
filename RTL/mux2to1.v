`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"

module mux2to1 #(parameter Len = 32)(
  input [Len-1:0] in0, in1,
  input sel,
  output [Len-1:0] out
);

  assign out = sel ? in1 : in0;

endmodule
