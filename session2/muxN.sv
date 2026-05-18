module muxN #(
    parameter int N = 4,
    parameter int WIDTH = 8
) (
input logic [WIDTH-1:0] data_in [N-1:0],
input logic [$clog2(N)-1:0] sel,
output logic [WIDTH-1:0]  y
);

assign y = data_in[sel];

endmodule 
