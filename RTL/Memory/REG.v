`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"

module REG(
  input           clk, rst,
  input   [4:0]   address1,
  input   [4:0]   address2,
  input   [4:0]   address_wb,
  input           regwrite,
  input   [`WIDTH-1:0]  data_wb,
  output  [`WIDTH-1:0]  data1,
  output  [`WIDTH-1:0]  data2
);
  integer i;
  reg [`WIDTH-1:0] REGISTER[31:0];  // Register file with 32 registers, each `WIDTH` bits wide

  // Reset and Write operation on the negative edge of the clock
  always @(negedge clk) begin
    if (!rst) begin
      // Reset all registers to 0
      for (i = 0; i < 32; i = i + 1) begin
        REGISTER[i] <= 0;
      end
    end else if (regwrite) begin
      REGISTER[address_wb] <= data_wb;
    end
  end 

  // Combinational read logic
  assign data1 = (address1 != 0) ? REGISTER[address1] : 0;
  assign data2 = (address2 != 0) ? REGISTER[address2] : 0;

endmodule
