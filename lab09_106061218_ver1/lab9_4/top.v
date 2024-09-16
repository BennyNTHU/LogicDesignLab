`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    inout PS2_DATA,
    inout PS2_CLK,
    output [7:0] BCD,
    output [3:0] ssd_ctl
    );
    
wire [511:0] key_down;
wire [8:0] last_change;
wire key_valid;

wire [3:0] ASCII_1;
wire [3:0] ASCII_2;
wire [3:0] ASCII_3;

KeyboardDecoder U0 (.clk(clk), .rst(rst), .key_down(key_down), .last_change(last_change),
                    .key_valid(key_valid), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK));
last_change_decoder U1 (.clk(clk), .rst(rst), .key_down(key_down), .last_change(last_change),
                        .ASCII_1(ASCII_1), .ASCII_2(ASCII_2), .ASCII_3(ASCII_3));
ssd U2 (.clk(clk), .rst(rst), .digit1(ASCII_1), .digit2(ASCII_2), .digit3(ASCII_3),
        .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule