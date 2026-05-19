module tb_comparator;

    logic [7:0] a, b;
    logic       eq, lt, gt;

comparator dut (
        .a  (a),
        .b  (b),
        .eq (eq),
        .lt (lt),
        .gt (gt)
    );

    task check(input logic [7:0] stim_a,
               input logic [7:0] stim_b,
               input logic       exp_eq,
               input logic       exp_lt,
               input logic       exp_gt,
               input string      label);
        a = stim_a;
        b = stim_b;
        #10;
        if (eq === exp_eq && lt === exp_lt && gt === exp_gt)
            $display("PASS  | %s  a=%0d b=%0d eq=%b lt=%b gt=%b",
                     label, a, b, eq, lt, gt);
        else
            $display("FAIL  | %s  a=%0d b=%0d got(eq=%b,lt=%b,gt=%b) exp(eq=%b,lt=%b,gt=%b)",
                     label, a, b, eq, lt, gt, exp_eq, exp_lt, exp_gt);
    endtask

    initial begin
        $dumpfile("wave_comparator.vcd");
        $dumpvars(0, tb_comparator);

        $display("=== EQUALITY CASES ===");
        check(8'd0,   8'd0,   1'b1, 1'b0, 1'b0, "0 == 0");
        check(8'd42,  8'd42,  1'b1, 1'b0, 1'b0, "42 == 42");
        check(8'd255, 8'd255, 1'b1, 1'b0, 1'b0, "255 == 255 (max)");

        $display("=== LESS-THAN CASES ===");
        check(8'd0,   8'd1,   1'b0, 1'b1, 1'b0, "0 < 1");
        check(8'd50,  8'd100, 1'b0, 1'b1, 1'b0, "50 < 100");
        check(8'd254, 8'd255, 1'b0, 1'b1, 1'b0, "254 < 255 (just-below-max)");

        $display("=== GREATER-THAN CASES ===");
        check(8'd1,   8'd0,   1'b0, 1'b0, 1'b1, "1 > 0");
        check(8'd100, 8'd50,  1'b0, 1'b0, 1'b1, "100 > 50");
        check(8'd255, 8'd0,   1'b0, 1'b0, 1'b1, "255 > 0 (max range)");

        $display("=== INVARIANT CHECK ===");
        $display("(Each test confirms exactly one of eq/lt/gt is high)");

        $display("=== Test complete ===");
        $finish;
    end

endmodule