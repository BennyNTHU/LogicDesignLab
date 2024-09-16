`timescale 1ns / 1ps

module shifter(
    input clk,
    input rst,
    input [7:0] random,
    output reg [7:0] f
    );

always@ (posedge clk or negedge rst)
    if (~rst)
        f <= random;
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
