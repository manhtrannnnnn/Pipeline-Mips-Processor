`include "defines.v"

module adder(
  input [`WIDTH-1:0] a, b,
  output [`WIDTH-1:0] sum
);

  assign sum = a + b;

endmodule
