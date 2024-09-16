`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    output [3:0] ssd_ctl,
    output [7:0] BCD
    );

wire clk_1Hz;
wire [3:0] cnt;

freq_div U0 (.clk(clk), .rst(rst), .signal(clk_1Hz));
counter U1 (.clk(clk_1Hz), .rst(rst), .out(cnt));
ssd U2 (.cnt(cnt), .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule
