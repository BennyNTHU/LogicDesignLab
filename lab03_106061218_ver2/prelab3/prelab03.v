`timescale 1ns / 1ps

module counter(out, clk, rst);

input clk;
input rst;
output reg [3:0] out;
reg [3:0] tmp_cnt;
    
always @(posedge clk or negedge rst)
    if (~rst)
        out <= 4'b0000;
    else
        out <= tmp_cnt;

always @*
    if (out == 9)
        tmp_cnt <= 4'b0000;
    else
        tmp_cnt <= out + 4'b0001;    
        
endmodule
