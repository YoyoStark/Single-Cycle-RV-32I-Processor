module RegisterFile #(
    parameter Depth = 32,
    parameter Width = 32
)
(
    input reset,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [Width-1:0] WD3,
    input WE3,
    input CLK,
    output reg [Width-1:0] RD1,
    output reg [Width-1:0] RD2
);

    reg [Width-1:0] regfile [0:Depth-1];
    integer i;

always @(posedge CLK or negedge reset) 
begin
    if (!reset) 
    begin
        for (i = 0; i < Depth; i = i + 1) 
        begin
            regfile[i] <= 0;  //{Width{1'b0}};
        end
    end
    else if (WE3) 
    begin
        regfile[A3] <= WD3;
    end
end

always @(*) begin
   assign RD1 = regfile[A1];
   assign RD2 = regfile[A2];
end

endmodule