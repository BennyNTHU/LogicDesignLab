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

KeyboardDecoder U0 (.clk(clk), .rst(rst), .key_down(key_down), .last_change(last_change),
                    .key_valid(key_valid), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK));
ssd U1 (.clk(clk), .rst(rst), .last_change(last_change), .ssd_ctl(ssd_ctl), .BCD(BCD));
          
endmodule
