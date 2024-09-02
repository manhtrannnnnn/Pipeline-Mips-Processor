`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"


module control(
  input [5:0] opcode, funct,
  output  regwrite, memtoreg,
  output  memwrite, alusrc,
  output  regdst, jump, branch,
  output reg [1:0] branch_condition,
  output reg [3:0] alucontrol
);

reg [6:0] tmp;
assign {regwrite, memtoreg, memwrite, alusrc, regdst, jump, branch} = tmp;

always @(*) begin
    // Reset all control signals
    tmp = 7'b0;  
    alucontrol = 4'b0;
    branch_condition = 2'b0;
    case (opcode)
        `R_op: begin
            tmp = `R_control;
            case (funct)
                `add_funct: alucontrol = `EXE_ADD;
                `and_funct: alucontrol = `EXE_AND;
                `sub_funct: alucontrol = `EXE_SUB;
                `or_funct:  alucontrol = `EXE_OR;
                `slt_funct: alucontrol = `EXE_SLT;
                `nor_funct: alucontrol = `EXE_NOR;
                `sll_funct: alucontrol = `EXE_SLL;
                `srl_funct: alucontrol = `EXE_SRL;
                default:    alucontrol = `EXE_NO_OPERATION;
            endcase
        end
        `lw_op:   begin tmp = `lw_control; alucontrol = `EXE_ADD; end
        `sw_op:   begin tmp = `sw_control; alucontrol = `EXE_ADD; end
        `addi_op: begin tmp = `addi_control; alucontrol = `EXE_ADD; end
        `andi_op: begin tmp = `andi_control; alucontrol = `EXE_AND; end
        `ori_op:  begin tmp = `ori_control; alucontrol = `EXE_OR; end
        `slti_op: begin tmp = `slti_control; alucontrol = `EXE_SLT; end
        `beq_op:  begin tmp = `beq_control; alucontrol = `EXE_NO_OPERATION; branch_condition = `beq; end
        `bne_op:  begin tmp = `bne_control; alucontrol = `EXE_NO_OPERATION; branch_condition = `bne; end
        `jump_op: begin tmp = `jump_control; alucontrol = `EXE_NO_OPERATION; end
        default:  begin tmp = 7'b0; alucontrol = 4'b0; branch_condition = 2'b0; end
    endcase
end

endmodule
