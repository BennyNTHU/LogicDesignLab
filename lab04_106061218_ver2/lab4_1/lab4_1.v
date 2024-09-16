`timescale 1ns / 1ps

module shifter(rst, f, clk);

input clk;
input rst;
output reg [7:0] f;

always@ (posedge clk or negedge rst)
    if (~rst)
        f <= 8'b01010101;
    else
    begin
        f[0]<=f[7];
        f[1]<=f[0];
        f[2]<=f[1];
        f[3]<=f[2];
        f[4]<=f[3];
        f[5]<=f[4];
        f[6]<=f[5];
        f[7]<=f[6]; 
    end
    
endmodule
