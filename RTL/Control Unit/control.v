`include "defines.v"

module control(
  input [5:0] opcode, funct,
  output reg regwrite_decode, memtoreg_decode,
  output reg memwrite_decode, alusrc_decode,
  output reg regdst_decode, jump_decode, branch_decode,
  output reg [1:0] branch_condition,
  output reg [3:0] alucontrol_decode
);

reg [6:0] tmp;
assign {regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, jump_decode, branch_decode} = tmp;

always @(*) begin
    // Reset all control signals
    tmp = 7'b0;  
    alucontrol_decode = 4'b0;
    branch_condition = 2'b0;

    case (opcode)
        `R_op: begin
            tmp = `R_control;
            case (funct)
                `add_funct: alucontrol_decode = `EXE_ADD;
                `and_funct: alucontrol_decode = `EXE_AND;
                `sub_funct: alucontrol_decode = `EXE_SUB;
                `or_funct:  alucontrol_decode = `EXE_OR;
                `slt_funct: alucontrol_decode = `EXE_SLT;
                `nor_funct: alucontrol_decode = `EXE_NOR;
                `sll_funct: alucontrol_decode = `EXE_SLL;
                `srl_funct: alucontrol_decode = `EXE_SRL;
                default:    alucontrol_decode = `EXE_NO_OPERATION;
            endcase
        end
        `lw_op:   begin tmp = `lw_control; alucontrol_decode = `EXE_ADD; end
        `sw_op:   begin tmp = `sw_control; alucontrol_decode = `EXE_ADD; end
        `addi_op: begin tmp = `addi_control; alucontrol_decode = `EXE_ADD; end
        `andi_op: begin tmp = `andi_control; alucontrol_decode = `EXE_AND; end
        `ori_op:  begin tmp = `ori_control; alucontrol_decode = `EXE_OR; end
        `slti_op: begin tmp = `slti_control; alucontrol_decode = `EXE_SLT; end
        `beq_op:  begin tmp = `beq_control; alucontrol_decode = `EXE_NO_OPERATION; branch_condition = `beq; end
        `bne_op:  begin tmp = `bne_control; alucontrol_decode = `EXE_NO_OPERATION; branch_condition = `bne; end
        `jump_op: begin tmp = `jump_control; alucontrol_decode = `EXE_NO_OPERATION; end
        default:  begin tmp = 7'b0; alucontrol_decode = 4'b0; branch_condition = 2'b0; end
    endcase
end

endmodule
