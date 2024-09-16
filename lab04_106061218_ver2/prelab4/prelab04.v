`timescale 1ns / 1ps

module prelab04(rst, clk, f);

input rst;
input clk;
output reg [7:0] f;

always@ (posedge clk or posedge rst)
    if (rst)
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
