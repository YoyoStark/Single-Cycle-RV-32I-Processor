module ControlUnit (
    input [6:0] opcode,
    input [2:0] funct3,
    input funct7,
    input zero,
    input sign,
    output reg RegWrite,
    output reg MemWrite,
    output reg ResultSrc,
    output reg [1:0] ImmSrc,
    output reg ALUSrc,
    output reg [2:0] ALUcontrol,
    output reg PCSrc
);

wire branch ; 
wire [1:0] ALUOp;


    always @(*)
    begin
         case (funct3)
         3'b000: PCSrc = zero & branch; // BEQ
         3'b001: PCSrc = ~zero & branch; // BNE
         3'b100: PCSrc = sign & branch; // BLT

         default : PCSrc = 1'b0; // mafee4 branching
         endcase
    end

MainDecoder main_decoder (
    .opcode(opcode),
    .ALUOp(ALUOp),
    .ImmSrc(ImmSrc),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .branch(branch)
);

ALUDecoder alu_decoder (
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .OP5(opcode[5]),
    .ALUcontrol(ALUcontrol)
);

    
endmodule