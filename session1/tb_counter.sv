module tb_counter;

    // Signals to connect to the DUT
    logic       clk;
    logic       rst;
    logic [3:0] count;

    // Instantiate the Device Under Test
    counter dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock generator: toggle clk every 5 time units
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus: assert reset, then release it, then run for a while
    initial begin
        // Setup waveform dumping
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_counter);

        // Print a header
        $display("Time | rst | count");
        $display("-----+-----+------");

        // Monitor: print whenever count changes
        $monitor("%4t |  %b  |  %0d", $time, rst, count);

        // Reset sequence
        rst = 1;
        #20;        // hold reset high for 20 time units
        rst = 0;    // release reset

        // Run for 200 more time units, then stop
        #200;
        $display("Simulation complete.");
        $finish;
    end

endmodule
