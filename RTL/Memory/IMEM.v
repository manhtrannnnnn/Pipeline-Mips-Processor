`include "defines.v"

module IMEM (
    input   [`WIDTH-1:0]  pc,
    output wire [`WIDTH-1:0] instr
);
  reg [`WIDTH-1:0] instr_memory[31:0];

  // Optional: Initialize instruction memory
  initial begin
    $readmemh("instr_mem_init.hex", instr_memory);
  end

  assign instr = instr_memory[pc[`WIDTH-1:2]];
  
endmodule