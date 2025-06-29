module InstructionMemory #(
    parameter Depth = 256,
    parameter Width = 32
)
(
    input [31:0] address,
    output reg [31:0] instruction
);

    reg [Width-1:0] memory [0:Depth-1]; // 256 words of instruction memory

initial begin
    $readmemh("program.hex", memory);  // OR $readmemb for binary
end

    always @(*) begin
        instruction = memory[address[31:2]]; // Fetch instruction based on address
    end

endmodule
 
