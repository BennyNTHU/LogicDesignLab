`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    output [3:0] bcd
    );

wire clk_1Hz;

freq_div U0 (.clk(clk), .rst(rst), .clk_1Hz(clk_1Hz));
counter U1 (.clk(clk_1Hz), .rst(rst), .bcd(bcd));

endmodule
