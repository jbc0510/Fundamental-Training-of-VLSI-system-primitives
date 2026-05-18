module tb_adder8;

    logic [7:0] a, b, sum;
    logic       cin, cout;

    adder8 dut (
        .a    (a),
        .b    (b),
        .cin  (cin),
        .sum  (sum),
        .cout (cout)
    );

    // Reusable check task
    task check(input logic [7:0] stim_a,
               input logic [7:0] stim_b,
               input logic       stim_cin,
               input logic [7:0] exp_sum,
               input logic       exp_cout,
               input string      label);
        a   = stim_a;
        b   = stim_b;
        cin = stim_cin;
        #10;
        if (sum === exp_sum && cout === exp_cout)
            $display("PASS  | %s  %0d + %0d + %0d = sum=%0d cout=%0d",
                     label, a, b, cin, sum, cout);
        else
            $display("FAIL  | %s  got(sum=%0d,cout=%0d) exp(sum=%0d,cout=%0d)",
                     label, sum, cout, exp_sum, exp_cout);
    endtask

    initial begin
        $dumpfile("wave_adder8.vcd");
        $dumpvars(0, tb_adder8);

        $display("=== NORMAL ADDITION ===");
        check(8'd5,   8'd3,   1'b0, 8'd8,   1'b0, "5+3+0");
        check(8'd100, 8'd50,  1'b0, 8'd150, 1'b0, "100+50+0");

        $display("=== CARRY-IN ===");
        check(8'd5,   8'd3,   1'b1, 8'd9,   1'b0, "5+3+1");
        check(8'd0,   8'd0,   1'b1, 8'd1,   1'b0, "0+0+1 (cin alone)");

        $display("=== CARRY-OUT (overflow) ===");
        check(8'd255, 8'd1,   1'b0, 8'd0,   1'b1, "255+1 overflows to 0");
        check(8'd200, 8'd100, 1'b0, 8'd44,  1'b1, "200+100=300, wraps to 44");

        $display("=== EDGE CASE ===");
        check(8'd255, 8'd255, 1'b1, 8'd255, 1'b1, "0xFF+0xFF+1 = 0x1FF");

        $display("=== Test complete ===");
        $finish;
    end

endmodule
