module tb_decoder;

    localparam int N = 4;
    logic [$clog2(N)-1:0] sel;
    logic [N-1:0]         onehot;
    logic [N-1:0]         expected;
   decoder #(
        .N (N)
    ) dut (
        .sel    (sel),
        .onehot (onehot)
    ); 
    initial begin
        $dumpfile("wave_decoder.vcd");
        $dumpvars(0, tb_decoder);

        for (int i = 0; i < N; i++) begin
            sel = i[$clog2(N)-1:0];
            expected = N'(1'b1 << i);
            #10;
            if (onehot === expected)
                $display("Time %0t: sel=%0d, onehot=%b, expected=%b | PASS",
                         $time, sel, onehot, expected);
            else
                $display("Time %0t: sel=%0d, onehot=%b, expected=%b | FAIL",
                         $time, sel, onehot, expected);
        end
        $display("=== Test complete ===");
        $finish;
    end

endmodule