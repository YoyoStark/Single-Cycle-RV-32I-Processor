`timescale 1ns/1ps

module tb_ProgramCounter;

    reg [31:0] PCnext;
    reg [31:0] ImmExt;
    reg PCSrc;
    reg clk;
    reg Areset;
    reg load;
    wire [31:0] PC;

    ProgramCounter uut (
        .PCnext(PCnext),
        .ImmExt(ImmExt),
        .PCSrc(PCSrc),
        .clk(clk),
        .Areset(Areset),
        .load(load),
        .PC(PC)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Time\tReset\tLoad\tPCSrc\tPCnext\tImmExt\tPC");
        $monitor("%0t\t%b\t%b\t%b\t%h\t%h\t%h", $time, Areset, load, PCSrc, PCnext, ImmExt, PC);

        // Initialize
        Areset = 0; load = 0; PCSrc = 0;
        PCnext = 32'h00000004;
        ImmExt = 32'h00000008;

        // Apply reset
        #3 Areset = 1;  // active-low reset deasserted
        #2 Areset = 0;  // trigger reset
        #10 Areset = 1; // release reset

        // Load PCnext (PCSrc = 0)
        #5 load = 1; PCSrc = 0; PCnext = 32'h00000010;

        // Load branch target (PCSrc = 1)
        #10 PCSrc = 1; ImmExt = 32'h00000004;

        // Try load = 0 (should hold)
        #10 load = 0;

        // Load PCnext again
        #10 load = 1; PCSrc = 0; PCnext = 32'h00000020;

        #20 $finish;
    end

endmodule
