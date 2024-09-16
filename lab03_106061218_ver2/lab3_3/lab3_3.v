`timescale 1ns / 1ps

module counter(
    input clk,
    input rst,
    output reg [3:0] bcd,
    reg [3:0] bcd_temp
    );

always@ (posedge clk or negedge rst)
    if (~rst)
        bcd <= 4'b0000;
    else 
        bcd <= bcd_temp;

always @*
    if (bcd > 9)
        bcd_temp = 4'b0000;
    else
        bcd_temp = bcd + 4'b0001;        

endmodule
