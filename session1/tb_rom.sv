module tb_rom;

    logic       clk;
    logic [3:0] addr;
    logic [7:0] data;

    // Scoreboard: the expected contents of the ROM
    logic [7:0] expected [0:15];
    int         pass_count;
    int         fail_count;

    // Instantiate the ROM
    rom dut (
        .clk(clk),
        .addr(addr),
        .data(data)
    );

    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus + scoreboard
    initial begin
        $dumpfile("wave_rom.vcd");
        $dumpvars(0, tb_rom);

        // Initialize counters
        pass_count = 0;
        fail_count = 0;

        // Load the same hex file into the expected array
        $readmemh("golden.hex", expected);

        $display("Time | addr | data | expected | result");
        $display("-----+------+------+----------+--------");

        // Start at address 0, give the ROM one cycle to settle
        addr = 4'h0;
        #15;

        // Walk through every address, check the result
        for (int i = 0; i < 16; i = i + 1) begin
            addr = i[3:0];
            #10;  // wait one clock period for the read to complete

            // Compare what we got to what we expected
            if (data === expected[i]) begin
                $display("%4t |  %h   |  %h  |    %h    | PASS",
                         $time, addr, data, expected[i]);
                pass_count = pass_count + 1;
            end else begin
                $display("%4t |  %h   |  %h  |    %h    | FAIL",
                         $time, addr, data, expected[i]);
                fail_count = fail_count + 1;
            end
        end

        // Final summary
        $display("");
        $display("=================================");
        $display("SCOREBOARD: %0d PASS, %0d FAIL", pass_count, fail_count);
        $display("=================================");

        if (fail_count == 0)
            $display("RESULT: ALL TESTS PASSED");
        else
            $display("RESULT: %0d TESTS FAILED", fail_count);

        $finish;
    end

endmodule
