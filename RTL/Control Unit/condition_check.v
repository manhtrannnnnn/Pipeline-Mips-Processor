`include "defines.v"

module condition_check(
  input [`WIDTH-1:0] in1, in2,
  input [1:0] branch_condition,
  output reg branch_check
);

  always @(*) begin
    case(branch_condition) 
      `beq: branch_check = (in1 == in2);
      `bne: branch_check = (in1 != in2);
      `not_branch: branch_check = 0;
      default: branch_check = 0;
    endcase
  end

endmodule
