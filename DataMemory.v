module DataMemory # 
(
    parameter dep = 64, wid = 32
)
(
    input [wid-1:0] address,
    input [wid-1:0] WD,
    input WE,
    input clk,
    output reg [wid-1:0] read_data
);

//reg [wid-1:0] memory [0:dep-1]; // 64 words of data memory
reg [wid-1:0] memory [0:dep-1]; // 64 words of data memory

always @(posedge clk) 
begin
    if (WE)
    begin
        memory[address[31:2]] <= WD;  // write data to memory
    end
end

always @(*) 
begin
    read_data = memory[address[31:2]]; // Read data 
end

endmodule