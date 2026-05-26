module barrel_shifter(
input logic [7:0] data_in,
input logic [2:0] shift_amt,
output logic [7:0] data_out
);
logic [7:0] stage0, stage1;
assign stage0 = shift_amt[0] ? {data_in[6:0], 1'b0}  : data_in;
assign stage1 = shift_amt[1] ? {stage0[5:0],  2'b0}  : stage0;
assign data_out = shift_amt[2] ? {stage1[3:0],  4'b0} : stage1;

endmodule 