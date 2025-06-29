module ALUDecoder (
    input [1:0] ALUOp,                
    input [2:0] funct3,
    input funct7,
    input OP5,                      // 5th bit of opcode
    output reg [2:0] ALUcontrol
);


always @(*)
begin
    case (ALUOp)
        2'b00: ALUcontrol = 3'b000; 
        2'b01: ALUcontrol = 3'b010; 
        2'b10: begin
            case (funct3)
                3'b000: ALUcontrol = (OP5 ==1'b1 && funct7 == 1'b1) ? 3'b010 : 3'b000; // law 11 sub 8er keda add
                3'b001: ALUcontrol = 3'b001;                                     // Shift left   
                3'b100: ALUcontrol = 3'b100;                                     // XOR 
                3'b101: ALUcontrol = 3'b101;                                     // Shift right  
                3'b110: ALUcontrol = 3'b110;                                     // OR    
                3'b111: ALUcontrol = 3'b111;                                     // AND
                default: ALUcontrol = 3'b000;
            endcase
        end
        default: ALUcontrol = 3'b000;
    endcase  
end
    
endmodule