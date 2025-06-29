# Single-Cycle RV32I Processor

This project implements a fully functional **single-cycle RISC-V (RV32I)** processor in Verilog. The design follows a modular, Harvard-style architecture and supports a subset of the RV32I instruction set.

## 🔧 Features

- 32-bit data path (RV32I)
- 32 general-purpose registers
- Single-cycle datapath
- Supports:
  - R-type: ADD, SUB, AND, OR, XOR, SLT, etc.
  - I-type: ADDI, ANDI, ORI, LW, etc.
  - S-type: SW
  - B-type: BEQ, BNE, BLT, BGE
  - U-type: LUI, AUIPC
  - J-type: JAL
- Immediate Generator
- Program Counter with branch logic
- Instruction and Data Memory modules
- Synthesizable on FPGA

## 📁 Project Structure

├── ALU.v
├── ControlUnit.v
├── DataMemory.v
├── ImmediateGenerator.v
├── InstructionMemory.v
├── ProgramCounter.v
├── RegisterFile.v
├── RiscV_Processor.v <-- Top-level module
├── program.hex <-- Preloaded instruction memory

![image](https://github.com/user-attachments/assets/a7034406-eee3-4b9b-a34f-f89aad3b9d40)


## 🚀 How to Simulate

1. Compile the Verilog files using ModelSim, Icarus, or any simulator of your choice.
2. Load `program.hex` into `InstructionMemory`.
3. Run the simulation and observe register/memory updates.
4. Optionally, test using a waveform viewer to inspect PC, ALU results, and memory behavior.

## 📦 Preload Sample Program

Make sure your `InstructionMemory` module includes:

```verilog
initial begin
    $readmemh("program.hex", memory);
end

🤝 Contributing
Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

🧠 Credits
Project by Yahia Galal
Cairo University – Faculty of Engineering
Credit Hour Programs - CCE - Electronics and Communication track
for contacts : yahia.ibrahim04@eng-st.cu.edu.eg
