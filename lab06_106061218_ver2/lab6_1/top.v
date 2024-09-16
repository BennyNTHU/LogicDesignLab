`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    input dip,
    output [3:0] ssd_ctl,
    output [7:0] BCD
    );

wire clk_1Hz;
wire clk_hr;
wire [3:0] min1, min2;
wire [3:0] hour1_tmp, hour2_tmp;
wire [3:0] hour1, hour2;

freq_div U0 (.clk(clk), .rst(rst), .signal(clk_1Hz));
min_counter U1 (.clk(clk_1Hz), .rst(rst), .limit(59), .start(0), .carry(clk_hr), .min1(min1), .min2(min2));
hour_counter U2 (.clk(clk_hr), .rst(rst), .limit(23), .start(0), .hour1(hour1_tmp), .hour2(hour2_tmp));
decide U3 (.clk(clk), .rst(rst), .dip(dip), .hour1_tmp(hour1_tmp), .hour2_tmp(hour2_tmp), .hour1(hour1), .hour2(hour2));
ssd U4 (.clk(clk), .rst(rst), .hour1(hour1), .hour2(hour2), .min1(min1), .min2(min2), .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule
