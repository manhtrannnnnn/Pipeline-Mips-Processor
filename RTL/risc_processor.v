`include "D:/BACH KHOA/Internship/pipeline-processor/RTL/defines.v"

module risc_processor(
    input clk, rst
);


// Wire Declarations
    // Instruction Fetch Stage
    wire [`WIDTH-1:0] pc_fetch, instr_fetch;
    wire [`WIDTH-1:0] pc_decode, instr_decode;

    // Instruction Decode Stage
    wire regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, jump_decode, branch_decode;
    wire [`WIDTH-1:0] signext_decode;
    wire [3:0] alucontrol_decode;
    wire pcsrc_decode, flush_decode;
    wire [`WIDTH-1:0] pc_branch, pc_jump, data1_decode, data2_decode;
    wire regwrite_exe, memtoreg_exe, memwrite_exe, alusrc_exe, regdst_exe;
    wire [3:0] alucontrol_exe;
    wire [`WIDTH-1:0] data1_exe, data2_exe;
    wire [4:0] Rs_exe, Rt_exe, Rd_exe, shamt_exe;
    wire [`WIDTH-1:0] signext_exe;

    // Execute Stage
    wire [`WIDTH-1:0] aluout_exe, writedata_exe;
    wire [4:0] regaddr_exe;
    wire regwrite_mem, memtoreg_mem, memwrite_mem;
    wire [`WIDTH-1:0] aluout_mem, writedata_mem;
    wire [4:0] regaddr_mem;

    //Hazards Unit
    wire stall_pc, stall_decode, forwardA_decode, forwardB_decode, flush_exe, stall_compare;
    wire [1:0] forwardA_exe, forwardB_exe;

    // Memory Stage
    wire [`WIDTH-1:0] readdata_mem;
    wire regwrite_wb, memtoreg_wb;
    wire [`WIDTH-1:0] aluout_wb, readdata_wb;
    wire [4:0] regaddr_wb;

    // Write Back Stage
    wire [`WIDTH-1:0] result_wb;

    


// Instruction Fetch Stage
    // Stage
    IFStage ifstage(clk, rst, jump_decode, pcsrc_decode, stall_pc, pc_branch, pc_jump, instr_fetch, pc_fetch);
    // Register
    IF2ID if2id(clk, rst, stall_decode, flush_decode, pc_fetch, instr_fetch, pc_decode, instr_decode);

// Instruction Decode Stage
    // Stage
    IDStage idstage(clk, rst, instr_decode, pc_decode, result_wb, aluout_mem, regaddr_wb, forwardA_decode, forwardB_decode, stall_compare , regwrite_wb, regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, jump_decode, branch_decode, alucontrol_decode, pcsrc_decode, flush_decode, pc_branch, pc_jump, signext_decode, data1_decode, data2_decode);
    // Register
    ID2EXE id2exe(clk, rst, flush_exe, regwrite_decode, memtoreg_decode, memwrite_decode, alusrc_decode, regdst_decode, alucontrol_decode, data1_decode, data2_decode, instr_decode[25:21], instr_decode[20:16], instr_decode[15:11], instr_decode[10:6], signext_decode, regwrite_exe, memtoreg_exe, memwrite_exe, alusrc_exe, regdst_exe, alucontrol_exe, data1_exe, data2_exe, Rs_exe, Rt_exe, Rd_exe, shamt_exe, signext_exe);

// Execute Stage
    // Stage
    EXEStage exestage(alusrc_exe, regdst_exe, alucontrol_exe, data1_exe, data2_exe, Rt_exe, Rd_exe, shamt_exe, signext_exe, forwardA_exe, forwardB_exe, aluout_mem, result_wb, aluout_exe, writedata_exe, regaddr_exe);
    // Register
    EXE2MEM exe2mem(clk, rst, regwrite_exe, memtoreg_exe, memwrite_exe, aluout_exe, writedata_exe, regaddr_exe, regwrite_mem, memtoreg_mem, memwrite_mem, aluout_mem, writedata_mem, regaddr_mem);

// Memory Stage
    // Stage
    MEMStage memstage(clk, memwrite_mem, aluout_mem, writedata_mem, readdata_mem);
    // Register
    MEM2WB mem2wb(clk, rst, regwrite_mem, memtoreg_mem, aluout_mem, readdata_mem, regaddr_mem, regwrite_wb, memtoreg_wb, aluout_wb, readdata_wb, regaddr_wb);

// Write Back Stage
    // Stage
    WBStage wbstage(memtoreg_wb, readdata_wb, aluout_wb, result_wb);


// Hazards Unit
    hazardUnit hazard(branch_decode, instr_decode[25:21], instr_decode[20:16], Rs_exe, Rt_exe, memtoreg_exe, regwrite_exe, regaddr_exe, regwrite_mem, memtoreg_mem, regaddr_mem, regwrite_wb, regaddr_wb, stall_pc, stall_decode, stall_compare, forwardA_decode, forwardB_decode, flush_exe, forwardA_exe, forwardB_exe);

endmodule