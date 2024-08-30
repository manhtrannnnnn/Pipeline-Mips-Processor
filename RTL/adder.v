`include "defines.v"

module adder(
  input [`WIDTH-1:0] in1, in2,
  output [`WIDTH-1:0] sum
);

  assign sum = in1 + in2;

endmodule
