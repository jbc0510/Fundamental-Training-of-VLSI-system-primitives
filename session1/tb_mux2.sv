module tb_mux2;

    logic [7:0] a, b, y;
    logic       sel;

    mux2 dut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        $dumpfile("wave_mux2.vcd");
        $dumpvars(0, tb_mux2);

        // Initialize inputs
        a   = 8'hAA;
        b   = 8'h55;
        sel = 1'b0;
        #10;

        // Test 1: sel = 0 should route a to y
        if (y === a) $display("PASS: sel=0, y=%h matches a=%h", y, a);
        else         $display("FAIL: sel=0, y=%h, expected a=%h", y, a);

        // Test 2: flip sel to 1, y should now be b
        sel = 1'b1;
        #10;
        if (y === b) $display("PASS: sel=1, y=%h matches b=%h", y, b);
        else         $display("FAIL: sel=1, y=%h, expected b=%h", y, b);

        // Test 3: flip sel back to 0
        sel = 1'b0;
        #10;
        if (y === a) $display("PASS: sel=0 again, y=%h matches a=%h", y, a);
        else         $display("FAIL: sel=0 again, y=%h, expected a=%h", y, a);

        sel = 0;
        #10;
        sel = 1;
        #10;
        sel = 0;
        #10;
        sel = 1;
        #10;

        $finish;
    end

endmodule