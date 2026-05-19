module comparator (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic     eq,
    output logic     lt,
    output logic     gt 
);

    assign eq = (a == b);
    assign lt = (a < b);
    assign gt = (a > b);
    
endmodule 