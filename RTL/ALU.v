`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"

module ALU(
  input [`WIDTH-1:0] val1, val2,
  input [4:0] shamt,
  input [3:0] alucontrol_exe,
  output reg [`WIDTH-1:0] aluout
);

  always @(*) begin
    case(alucontrol_exe)
      `EXE_ADD: aluout = val1 + val2;
      `EXE_AND: aluout = val1 & val2;
      `EXE_SUB: aluout = val1 - val2;
      `EXE_OR:  aluout = val1 | val2;
      `EXE_SLT: aluout = (val1 < val2);
      `EXE_NOR: aluout = ~(val1 | val2);  
      `EXE_SLL: aluout = val2 << shamt;
      `EXE_SRL: aluout = val2 >> shamt;
      `EXE_NO_OPERATION: aluout = 0;
      default: aluout = 0;
    endcase
  end

endmodule