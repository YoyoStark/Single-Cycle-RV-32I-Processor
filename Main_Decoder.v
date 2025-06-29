module MainDecoder (
    input [6:0] opcode,
    output reg [1:0] ALUOp,      // beta3 el ALU
    output reg [1:0] ImmSrc,
    output reg MemWrite,
    output reg RegWrite,
    output reg resultSrc,
    output reg ALUSrc,
    output reg branch
);


    always @(*)
    begin

        case (opcode)

            7'b0000011:         //load word
            begin
                RegWrite = 1'b1;
                ImmSrc = 2'b00;
                ALUSrc= 1'b1;
                MemWrite = 1'b0;
                resultSrc = 1'b1;
                branch = 1'b0;
                ALUOp = 2'b00;
            end

            7'b0100011:             //store word
            begin
                RegWrite = 1'b0;
                ImmSrc = 2'b01;
                ALUSrc= 1'b1;
                MemWrite = 1'b1;
                resultSrc = 1'bx;
                branch = 1'b0;
                ALUOp = 2'b00;
            end

            7'b0110011:                 //R-type
            begin
                RegWrite = 1'b1;
                ImmSrc = 2'bxx;
                ALUSrc= 1'b0;
                MemWrite = 1'b0;
                resultSrc = 1'b0;
                branch = 1'b0;
                ALUOp = 2'b10;
            end

            7'b0010011:                 //I-type
            begin
                RegWrite = 1'b1;
                ImmSrc = 2'b00;
                ALUSrc= 1'b1;
                MemWrite = 1'b0;
                resultSrc = 1'b0;
                branch = 1'b0;
                ALUOp = 2'b10;
            end

            7'b1100011:                 // branch instruction 
            begin
                RegWrite = 1'b0;
                ImmSrc = 2'b10;
                ALUSrc= 1'b0;
                MemWrite = 1'b0;
                resultSrc = 1'bx;
                branch = 1'b1;
                ALUOp = 2'b01;
            end

            default:                        
            begin
                RegWrite = 1'b0;
                ImmSrc = 2'b00;
                ALUSrc= 1'b0;
                MemWrite = 1'b0;
                resultSrc = 1'b0;
                branch = 1'b0;
                ALUOp = 2'b00;
            end
        endcase
    end
endmodule