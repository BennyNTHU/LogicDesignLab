`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    output [3:0] ssd_ctl,
    output [7:0] BCD
    );
    
wire clk_1Hz;
wire [3:0] sec1, sec2;

freq_div U0 (.clk(clk), .rst(rst), .signal(clk_1Hz));
counter U1 (.clk(clk_1Hz), .rst(rst), .sec1(sec1), .sec2(sec2));
ssd U2 (.clk(clk), .rst(rst), .sec1(sec1), .sec2(sec2), .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule
