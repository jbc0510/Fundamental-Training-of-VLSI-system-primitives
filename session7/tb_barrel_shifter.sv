module tb_barrel_shifter;

    logic [7:0] data_in;
    logic [2:0] shift_amt;
    logic [7:0] data_out;

    barrel_shifter dut (
        .data_in   (data_in),
        .shift_amt (shift_amt),
        .data_out  (data_out)
    );

    // Reusable check task
    task check(input logic [7:0] stim_data,
               input logic [2:0] stim_shift,
               input logic [7:0] exp_out,
               input string      label);
        data_in   = stim_data;
        shift_amt = stim_shift;
        #10;
        if (data_out === exp_out)
            $display("PASS  | %s  data_in=%b shift=%0d  data_out=%b (%0d)",
                     label, data_in, shift_amt, data_out, data_out);
        else
            $display("FAIL  | %s  data_in=%b shift=%0d  got=%b exp=%b",
                     label, data_in, shift_amt, data_out, exp_out);
    endtask

    initial begin
        $dumpfile("wave_barrel_shifter.vcd");
        $dumpvars(0, tb_barrel_shifter);

        $display("=== SHIFT BY 0 (passthrough) ===");
        check(8'b0000_0001, 3'd0, 8'b0000_0001, "1 << 0 = 1");

        $display("=== SHIFT BY 1 (Stage 0 only) ===");
        check(8'b0000_0001, 3'd1, 8'b0000_0010, "1 << 1 = 2");

        $display("=== SHIFT BY 2 (Stage 1 only) ===");
        check(8'b0000_0001, 3'd2, 8'b0000_0100, "1 << 2 = 4");

        $display("=== SHIFT BY 3 (Stages 0+1) ===");
        check(8'b0000_0001, 3'd3, 8'b0000_1000, "1 << 3 = 8");

        $display("=== SHIFT BY 4 (Stage 2 only) ===");
        check(8'b0000_0001, 3'd4, 8'b0001_0000, "1 << 4 = 16");

        $display("=== SHIFT BY 5 (Stages 0+2) ===");
        check(8'b0000_0011, 3'd5, 8'b0110_0000, "3 << 5 = 96 (walkthrough case)");

        $display("=== SHIFT BY 6 (Stages 1+2) ===");
        check(8'b0000_0001, 3'd6, 8'b0100_0000, "1 << 6 = 64");

        $display("=== SHIFT BY 7 (all stages) ===");
        check(8'b0000_0001, 3'd7, 8'b1000_0000, "1 << 7 = 128 (max shift)");

        $display("=== TRUNCATION CASES (bits shift out) ===");
        check(8'b1111_1111, 3'd4, 8'b1111_0000, "0xFF << 4 truncates");
        check(8'b1000_0001, 3'd1, 8'b0000_0010, "0x81 << 1 loses high bit");

        $display("=== Test complete ===");
        $finish;
    end

endmodule