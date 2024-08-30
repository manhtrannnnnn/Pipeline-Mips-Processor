`include "defines.v"

module REG(
  input           clk, rst,
  input   [4:0]   address1,
  input   [4:0]   address2,
  input   [4:0]   address_wb,
  input           regwrite,
  input   [`WIDTH-1:0]  data_wb,
  output  reg [`WIDTH-1:0]  data1,
  output  reg [`WIDTH-1:0]  data2
);
  integer i;
  reg [31:0] REGISTER[31:0];

  // Write data on rising edge of clk (first half of the cycle)
  always @(posedge clk) begin
    if (!rst) begin
      // Reset all registers to 0
      for (i = 0; i < 32; i = i + 1) begin
        REGISTER[i] <= 0;
      end
    end else if (regwrite) begin
      REGISTER[address_wb] <= data_wb;
    end
  end 

  // Read data on falling edge of clk (second half of the cycle)
  always @(negedge clk) begin
    data1 <= (address1 != 0) ? REGISTER[address1] : 0;
    data2 <= (address2 != 0) ? REGISTER[address2] : 0;
  end

endmodule
