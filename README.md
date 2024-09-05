# 5-Stage Pipeline Processor Implementation


## Introduction

This project focuses on the design and simulation of a Pipelined MIPS (Microprocessor without Interlocked Pipeline Stages) processor using the Verilog hardware description language. Creating a processor that supports various MIPS instructions including arithmetic, logic, memory access, and control instructions. MIPS processors are a family of RISC (Reduced Instruction Set Computer) architectures known for their simplicity and efficiency.


## Features

- **Pipelined Design**: Implements a 5-stage pipeline architecture (IF, ID, EXE, MEM, WB) to execute multiple instructions concurrently.
- **Instruction Set**: Supports key MIPS instructions such as `add`, `sub`, `and`, `or`, `nor`, `sll`, `srl`, `slt`, `lw`, `sw`, `beq`, `bne`, `j`, and others.
- **Verilog Implementation**: The processor is described using Verilog HDL, making it synthesizable for FPGA implementation.


## Architecture 
Designing the pipelined processor by subdividing the single-cycle processor into five pipeline stages. Thus, five instructions can execute simultaneously, one in each stage. The output of the first stage become the input of the second stage, and so on. Besides, every stage operates on a different part of data, which allow multiple instructions to be in different stages of execution at the same time. However, effective hazard management—addressing data and control hazards—is essential to ensure smooth operation and maintain the integrity of instruction execution.

1. **Instruction Fetch (IF) Stage**: Getting instruction from memory by program counter (PC), and the PC is updated for the next instruction.
2. **Instruction Decode (ID) Stage**: The fetched instruction is decoded, and the necessary control signals are generated. The operands needed for operation are also read from the register file. This stage may stall if control hazards are present.
3. **Execution (EX) Stage**: The ALU performs the operation specified by the instruction. This stage may involve forwarding if data hazards are present.
4. **Memory Access (MEM) Stage**: If the instruction involves memory access (e.g., `lw` or `sw`), the calculated address is used to read or write data from/to memory. 
5. **Write Back (WB) Stage:**: The results from the EXE or MEM stage are written back to the appropriate register in the register file.
6. **Hazard Unit**: To ensure correct instruction flow and data integrity, the pipeline employs mechanisms such as forwarding, stalling, and flushing. These techniques address data hazards (when Read after Write), control hazards (due to branch instructions).

The diagram below provides a high-level view of the MIPS processor architecture:

![Processor Interface](https://github.com/manhtrannnnnn/Pipeline-Mips-Processor/blob/main/Picture/architecture.png)

## Project Structure

- **RTL**: Contains the Verilog source files for each module of the processor.
- **Verification**: Includes the testcase used for simulation and verification of the processor.
- **specification**: Documentation and diagrams related to the project.
- **README.md**: This file, providing an overview of the project.

## Testbench Overview

The testbench **risc_processor_tb** and **testcase** in `instruction.txt` is designed to thoroughly verify the execution of various instruction types within the pipelined processor. It ensures the processor correctly performs:

- **Arithmetic Operations**: Validates operations such as addition and subtraction.
- **Logical Operations**: Confirms the correct execution of logical instructions like AND and OR.
- **Shift Operations**: Tests the functionality of shift instructions.
- **Memory Access**: Checks proper loading from and storing to memory.
- **Branch and Jump Instructions**: Accurately evaluates branch conditions (e.g., `beq`, `bne`) and updates the program counter (PC) as needed for both branch and jump operations.

Additionally, the testcase validates the processor's handling of:

- **Data Hazards**: Implements techniques such as forwarding and stalling to resolve instructions dependent on previous results (e.g., register-to-register data dependencies) without errors.
- **Control Hazards**: Tests branch prediction, pipeline flushing, and stalling mechanisms to ensure correct instruction flow in the presence of branches.

This comprehensive testing framework guarantees the reliability and correctness of the pipelined processor's operation.

### Running the Simulation

To run the simulation, use the following command in your Verilog simulation environment (e.g., ModelSim, Vivado):
