module ALU 
(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [2:0] ALUControl,
    output reg [31:0] ALUResult,
    output reg Zero,
    output reg signflag
);

    always @(*)
    begin

    ALUResult = 32'h00000000;  // Default assignment
        
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB;            // Add
            3'b001: ALUResult = SrcA << SrcB[4:0];      // A SHL B
            3'b010: ALUResult = SrcA - SrcB;            // Sub
            3'b011: ALUResult = 32'h00000000;           // gad3ana meny , kont 3ayz a5aleh multiply 
            3'b100: ALUResult = SrcA ^ SrcB;            // XOR
            3'b101: ALUResult = SrcA >> SrcB[4:0];      // A SHR B
            3'b110: ALUResult = SrcA | SrcB;            // OR
            3'b111: ALUResult = SrcA & SrcB;            // A AND B
            default: ALUResult = 32'h00000000;          // Default case
        endcase
        
        if (ALUResult == 32'h00000000)
            Zero = 1'b1; 
        else
            Zero = 1'b0;

        signflag = ALUResult[31]; 
    end
    
endmodule