module RISC_V (
    input clk,
    input reset
);

    wire [31:0] SrcA, SrcB, instruction, MemoData, ALUresult, RD2, PC, ImmExt, result;
    wire [2:0] ALUcontrol;
    wire [1:0] ImmSrc;
    wire Zero, ALUSrc, sign , load , PCSrc, RegWrite, MemWrite, Resultsrc;


    assign SrcB = ALUSrc ? ImmExt : RD2; 

    ProgramCounter pc (
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .load(1'b1),
        .ImmExt(ImmExt),
        .PC(PC)
    );

    InstructionMemory instruction_memory (
        .address(PC),
        .instruction(instruction)
    );

    ControlUnit control_unit (
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[30]),
        .zero(Zero),
        .sign(sign),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ResultSrc(Resultsrc),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .ALUcontrol(ALUcontrol),
        .PCSrc(PCSrc)
    );

    ALU alu (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUcontrol),
        .Zero(Zero),
        .signflag(sign),
        .ALUResult(ALUresult)
    );

    RegisterFile reg_file (
        .CLK(clk),
        .reset(reset),
        .WE3(RegWrite),
        .A1(instruction[19:15]),
        .A2(instruction[24:20]),
        .A3(instruction[11:7]),
        .WD3(Resultsrc ? MemoData : ALUresult),
        .RD1(SrcA),
        .RD2(RD2)
    );

    DataMemory data_memory (
        .clk(clk),
        .WE(MemWrite),
        .address(ALUresult),
        .WD(RD2),
        .read_data(MemoData)
    );

    SignExtender sign_extender (
        .ImmIn(instruction[31:7]),
        .ImmSrc(ImmSrc),
        .ImmOut(ImmExt)
    );


endmodule