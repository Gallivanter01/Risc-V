# RISC-V Processor Core

## Overview
This repository contains a modular SystemVerilog implementation of a RISC-V microprocessor. The design strictly adheres to the standard **RV32I** (32-bit Base Integer) Instruction Set Architecture. The core is highly decoupled, breaking down the pipeline stages and instruction decoding logic into distinct, manageable sub-modules for maintainability and clarity.

## Architecture Highlights
* ISA: 32-bit RISC-V (RV32I Base Integer ISA)
* Hardware Description Language: SystemVerilog (`.sv`)
* Execution Pipeline: Modular separation of Fetch (IFU), Decode (IDU), Execution (IEU), and Memory Access phases.
* Decoding Strategy: Dedicated decode blocks for specific instruction formats (e.g., R-type, I-type, Branches, Jumps, Loads/Stores).
* Memory Interface: Includes an Instruction/Data Arbiter to manage concurrent memory requests from the fetch and memory stages.

## Repository Structure

```text
3_riscv/ver/
├── processor.sv                # Top-level processor wrapper
│
├── ifu.sv                      # Instruction Fetch Unit
│
├── idu.sv                      # Instruction Decode Unit (Main)
├── decode_branch_inst.sv       # Sub-decoder: Branch instructions (B-type)
├── decode_imm_inst.sv          # Sub-decoder: Immediate arithmetic (I-type)
├── decode_jump_inst.sv         # Sub-decoder: Jump instructions (JAL/JALR)
├── decode_load_inst.sv         # Sub-decoder: Load instructions
├── decode_reg_inst.sv          # Sub-decoder: Register-Register arithmetic (R-type)
├── decode_store_inst.sv        # Sub-decoder: Store instructions (S-type)
├── decode_upperimm_inst.sv     # Sub-decoder: Upper immediate (LUI/AUIPC)
│
├── regfile.sv                  # 32x32 General Purpose Register File
│
├── ieu.sv                      # Instruction Execution Unit
├── alu.sv                      # ALU top wrapper 
├── alu_core.sv                 # Core Arithmetic Logic Unit
├── branch.sv                   # Branch condition resolution
├── jump.sv                     # Jump address calculation
│
├── mem.sv                      # Memory stage controller
├── load.sv                     # Load data alignment and formatting
├── store.sv                    # Store data formatting
│
└── inst_data_arbiter.sv        # Arbiter handling I-Mem and D-Mem interface requests
