module RVTestbench ;
    reg clk;
    reg reset;

    RISC_V uut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0; 
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end
    initial begin
        reset = 1; // Assert reset
            #10; // Wait for 10 time units
            reset = 0; // Deassert reset
        end

    initial begin
        $monitor("Time: %0t, PC: %h, Instruction: %h, ALU Result: %h", 
                 $time, uut.PC, uut.instruction, uut.ALUresult);
    end

    initial begin
        #1000; // Adjust this value as needed for your test
        $finish; // End the simulation
    end

endmodule