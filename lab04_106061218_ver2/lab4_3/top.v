`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    output [3:0] ssd_ctl,
    output [7:0] cur_display
    );

wire clk_1Hz;

freq_div U0 (.clk(clk), .rst(rst), .signal(clk_1Hz));
ssd_shifter U1 (.clk(clk_1Hz), .rst(rst), .ssd_ctl(ssd_ctl), .cur_display(cur_display));
   
endmodule
