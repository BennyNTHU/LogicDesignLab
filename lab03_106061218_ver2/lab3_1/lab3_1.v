`timescale 1ns / 1ps

module lab3_1(clk, rst_n, div_out);
input clk;
input rst_n;
output div_out;
reg [26:0] out;
reg [26:0] cnt_tmp;

assign div_out = out[26];

always @* 
    cnt_tmp = out + 1'b1;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        out <= 27'd0;
    else
        out <= cnt_tmp; 

endmodule
