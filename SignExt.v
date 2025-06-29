module SignExtender (
    input [24:0] ImmIn,
    input [1:0] ImmSrc,
    output reg [31:0] ImmOut
);
    
    always @(*) begin
        
        case (ImmSrc)
            2'b00: ImmOut = { {20{ImmIn[24]}}, ImmIn[24:13] }; // I-type
            2'b01: ImmOut = { {20{ImmIn[24]}}, ImmIn[24:18] , ImmIn[4:0] }; // S-type
            2'b10: ImmOut = { {20{ImmIn[24]}}, ImmIn[0] ,ImmIn[23:18] , ImmIn[4:1] , 1'b0 }; // B-type
            default: ImmOut = 32'b0; // Default case
        endcase
    end 


endmodule