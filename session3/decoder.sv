module decoder #(
    parameter int N = 4
) (
    input  logic [$clog2(N)-1:0] sel,
    output logic [N-1:0]         onehot
);
assign onehot = (1'b1 << sel);
endmodule
