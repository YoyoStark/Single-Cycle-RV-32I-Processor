module ProgramCounter
 (
    input [31:0] ImmExt,
    input PCSrc,
    input clk,
    input Areset,
    input load,
    output reg [31:0] PC
);

    wire [31:0] PCnext;
    
    assign PCnext = (PCSrc) ? PC + ImmExt : PC + 4;


always @(posedge clk or negedge Areset)
begin
    if (!Areset)
    begin    
        PC <= 32'h00000000;
    end
    else
        begin
            if (load & !PCSrc)
            begin
                PC <= PCnext;
            end
            else if (load & PCSrc)
            begin
                PC <= PC + ImmExt;
            end
            else
            begin
                PC <= PC; // Maintain current value if not loading
            end
        end
end

endmodule