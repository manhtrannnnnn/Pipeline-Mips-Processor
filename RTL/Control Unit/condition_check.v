`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"


module condition_check(
  input [`WIDTH-1:0] in1, in2,
  input stall_compare,
  input [1:0] branch_condition,
  output reg branch_check
);

  always @(*) begin
    if(stall_compare) begin
      branch_check = 0;
    end
    else
    case(branch_condition) 
      `beq: branch_check = (in1 == in2);
      `bne: branch_check = (in1 != in2);
      `not_branch: branch_check = 0;
      default: branch_check = 0;
    endcase
  end

endmodule
