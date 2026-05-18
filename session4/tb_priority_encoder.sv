module tb_priority_encoder;

    localparam int N = 8;

    logic [N-1:0]         req;
    logic [$clog2(N)-1:0] index;
    logic                 valid;

    priority_encoder #(
        .N (N)
    ) dut (
        .req   (req),
        .index (index),
        .valid (valid)
    );

    task check(input logic [N-1:0] stim,
               input logic [$clog2(N)-1:0] exp_idx,
               input logic exp_valid,
               input string label);
        req = stim;
        #10;
        if (index === exp_idx && valid === exp_valid)
            $display("PASS  | %s  req=%b  index=%0d  valid=%b",
                     label, req, index, valid);
        else
            $display("FAIL  | %s  req=%b  got(idx=%0d,v=%b) exp(idx=%0d,v=%b)",
                     label, req, index, valid, exp_idx, exp_valid);
    endtask

    initial begin
        $dumpfile("wave_priority_encoder.vcd");
        $dumpvars(0, tb_priority_encoder);

        $display("=== SINGLE-BIT CASES ===");
        check(8'b00000001, 3'd0, 1'b1, "only bit 0");
        check(8'b00000010, 3'd1, 1'b1, "only bit 1");
        check(8'b00000100, 3'd2, 1'b1, "only bit 2");
        check(8'b10000000, 3'd7, 1'b1, "only bit 7");

        $display("=== MULTI-BIT CASES (priority test) ===");
        check(8'b00000011, 3'd0, 1'b1, "bits 0,1   -> 0 wins");
        check(8'b00001111, 3'd0, 1'b1, "bits 0..3 -> 0 wins");
        check(8'b11111111, 3'd0, 1'b1, "all bits  -> 0 wins");
        check(8'b11110000, 3'd4, 1'b1, "bits 4..7 -> 4 wins");

        $display("=== EDGE CASE ===");
        check(8'b00000000, 3'd0, 1'b0, "no requests, valid=0");

        $display("=== Test complete ===");
        $finish;
    end

endmodule