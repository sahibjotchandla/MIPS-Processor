# MIPS CPU Implementation in VHDL

<p align="center">
 <img src="https://github.com/sahibjotchandla/MIPS-Processor/blob/main/MIPS_CPU/cpu/images/architecture.png?raw=true" alt="MIPS CPU Architecture" width="750"/>
</p>

This project showcases the design and implementation of a MIPS processor using VHDL. The processor was simulated and validated on the Nexys A7 FPGA to demonstrate its functionality. Below, you'll find a detailed explanation of the architecture, its main components, and the validation process using a testbench.

## Overview

The MIPS processor is designed as a modular system, with each component implemented as an individual VHDL module. These components work together to execute fundamental arithmetic, logic, and control operations based on the MIPS instruction set. The design's functionality was verified thoroughly using a dedicated testbench.

### Key Features
- **Instruction Memory:** Stores the program instructions for execution.
- **Program Counter (PC):** Keeps track of the next instruction's memory address.
- **Control Unit:** Manages control signals to direct data flow and operations.
- **ALU (Arithmetic Logic Unit):** Executes arithmetic and logic operations.
- **Data Memory:** Facilitates data storage and retrieval for load/store instructions.
- **Register File:** Provides temporary storage for data during computation.

## Testbench Validation

To ensure the processor functions correctly, a VHDL testbench was used to simulate its operations. The testbench runs a series of instructions, simulates their execution, and generates waveform outputs for analysis.

<p align="center">
  <img src="https://github.com/sahibjotchandla/MIPS-Processor/blob/main/MIPS_CPU/cpu/images/tb.png" alt="Testbench Waveform" width="750"/>
</p>

### Testbench Workflow
1. **Instruction Fetch:** The instruction memory retrieves the next instruction based on the current program counter (PC).
2. **Instruction Decode:** The fetched instruction is decoded to determine the operation, such as ADD, SUB, LW, or SW.
3. **Execution:** The ALU performs the operation, and the result is written to the register file or data memory as required.
4. **Result Verification:** The testbench outputs key signals, such as PC, instruction, and register values, to a waveform for validation.

The testbench tracks the effect of random instructions on registers and memory, ensuring that all modules interact as expected. The MIPS instruction set diagram (below) aids in understanding how instructions are processed.

## MIPS Instruction Set

This processor supports a subset of MIPS-like instructions.

<p align="center">
 <img src="https://github.com/sahibjotchandla/MIPS-Processor/blob/main/MIPS_CPU/cpu/images/instructions.png" alt="Instruction Set" width="750"/>
</p>

### Instruction Format
- **Opcode (bits 15:12):** Determines the operation (e.g., ADD, SUB, LW, SW).
- **Rd, Rs, Rt (bits 11:0):** Specify the registers involved in the operation.
- **Immediate/Offset:** Used in branch, load, and store instructions.

### Example Instructions
- **ADD Rd, Rs, Rt:** Performs Rd = Rs + Rt.
- **LW Rd, offset(Rs):** Loads Rd with the value at Memory[Rs + offset].
- **BNE Rd, Rs, Imm:** If Rd != Rs, the program branches to PC + (Imm << 2).

## How to Run

1. Clone this repository:
   
   ```bash
   git clone https://github.com/your_username/mips-cpu.git
