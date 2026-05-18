module tb_muxN;
    localparam int N = 4;
    localparam int WIDTH = 8;
    logic [WIDTH-1:0]        data_in [N-1:0];
    logic [$clog2(N)-1:0]    sel;
    logic [WIDTH-1:0]        y;

    muxN #(
        .N     (N),
        .WIDTH (WIDTH)
    ) dut (
        .data_in (data_in),
        .sel     (sel),
        .y       (y)
    );

    initial begin
        $dumpfile("wave_muxN.vcd");
        $dumpvars(0, tb_muxN);

        // Load data_in[0]=0x10, data_in[1]=0x20, ... data_in[N-1]=N*0x10
        for (int i = 0; i < N; i++) begin
            data_in[i] = 8'((i + 1) * 8'h10);
        end

        for (int i = 0; i < N; i++) begin
            sel = i[$clog2(N)-1:0];
            #10;
            if (y === data_in[i])
                $display("Time %0t: sel=%0d, y=%h, expected=%h | PASS",
                         $time, sel, y, data_in[i]);
            else
                $display("Time %0t: sel=%0d, y=%h, expected=%h | FAIL",
                         $time, sel, y, data_in[i]);
        end
        $display("=== Test complete ===");
        $finish;
    end

endmodule
