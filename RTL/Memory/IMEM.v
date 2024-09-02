`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"


module IMEM (
    input   [`WIDTH-1:0]  pc,
    output  [`WIDTH-1:0] instr
);
  reg [`WIDTH-1:0] instr_memory[31:0];

  // Optional: Initialize instruction memory
  initial begin
    $readmemh("D:/BACH KHOA/Internship/pipeline-processor/Verification/instruction.txt", instr_memory);
  end

  assign instr = instr_memory[pc[`WIDTH-1:2]];
  
endmodule