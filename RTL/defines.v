`define WIDTH 32


// Opcode for instruction
//R-type
`define R_op    6'b000000 
//I-type
`define lw_op   6'b100011 
`define sw_op   6'b101011
`define addi_op 6'b001000
`define andi_op 6'b001100
`define ori_op  6'b001101
`define slti_op 6'b001010
`define beq_op  6'b000100
`define bne_op  6'b000101
//J-type 
`define jump_op 6'b000010

// Function for R-type
`define add_funct 6'b100000
`define and_funct 6'b100100
`define sub_funct 6'b100010
`define or_funct  6'b100101
`define slt_funct 6'b101010
`define nor_funct 6'b100111
`define sll_funct 6'b000000
`define srl_funct 6'b000010

// ALUControl
// To be used in side ALU
`define EXE_ADD 4'b0000
`define EXE_AND 4'b0001
`define EXE_SUB 4'b0010
`define EXE_OR  4'b0011
`define EXE_SLT 4'b0100
`define EXE_NOR 4'b0101
`define EXE_SLL 4'b0110
`define EXE_SRL 4'b0111
`define EXE_NO_OPERATION 4'b1111

// Using for control
`define R_control     7'b1000100
`define lw_control    7'b1101000
`define sw_control    7'b0011000
`define andi_control  7'b1001000
`define ori_control   7'b1001000
`define slti_control  7'b1001000
`define beq_control   7'b0000001
`define bne_control   7'b0000001
`define jump_control  7'b0000010

// Using for branch condition
`define beq 2'b11
`define bne 2'b01
`define not_branch 2'b00

