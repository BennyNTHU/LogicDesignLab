`timescale 1ns / 1ps
module lab1_3(in, en, d);

input [2:0] in;
input en;
output[7:0] d;

assign d[7] = en&(in[2])&(in[1])&(in[0]);
assign d[6] = en&(in[2])&(in[1])&(~in[0]);
assign d[5] = en&(in[2])&(~in[1])&(in[0]);
assign d[4] = en&(in[2])&(~in[1])&(~in[0]);
assign d[3] = en&(~in[2])&(in[1])&(in[0]);
assign d[2] = en&(~in[2])&(in[1])&(~in[0]);
assign d[1] = en&(~in[2])&(~in[1])&(in[0]);
assign d[0] = en&(~in[2])&(~in[1])&(~in[0]);

endmodule
