module priority_encoder #(
    parameter int N = 8 
) ( 
    input logic [N-1:0] req,
    output logic [$clog2(N)-1:0] index, 
    output logic valid
);

always_comb begin 
    index = '0;
    valid = 1'b0;
    for (int i = N-1; i >= 0; i--) begin
        if (req[i]) begin
            index = i[$clog2(N)-1:0];
            valid = 1'b1;
        end
    end
end

endmodule 
