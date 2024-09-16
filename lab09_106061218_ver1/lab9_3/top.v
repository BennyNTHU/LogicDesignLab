`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    inout PS2_DATA,
    inout PS2_CLK,
    output [7:0] BCD,
    output [3:0] ssd_ctl,
    output [2:0] state
    );
    
wire [511:0] key_down;
wire key_valid;
wire key_en;

wire [8:0] last_change;
wire [3:0] digit;

wire [3:0] digit1, digit2, digit3, digit4;
wire [3:0] digit1_tmp, digit2_tmp, digit3_tmp, digit4_tmp;
wire [3:0] mode;
wire show_en;

wire [3:0] result1, result2, result3, result4;

KeyboardDecoder U0 (.clk(clk), .rst(rst), .key_down(key_down), .last_change(last_change),
                    .key_valid(key_valid), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK));                
last_change_decoder U1 (.last_change(last_change), .digit(digit));
key_in_process U2 (.rst(rst), .key_down(key_down), .digit(digit), .last_change(last_change),
                   .digit1(digit1), .digit2(digit2), .digit3(digit3), .digit4(digit4),
                   .digit1_tmp(digit1_tmp), .digit2_tmp(digit2_tmp), .digit3_tmp(digit3_tmp), .digit4_tmp(digit4_tmp),
                   .state(state), .mode(mode), .show_en(show_en));
calculator U3 (.digit1(digit1), .digit2(digit2), .digit3(digit3), .digit4(digit4),
               .state(state), .mode(mode),
               .result1(result1), .result2(result2), .result3(result3), .result4(result4));
ssd U4 (.digit1(digit1_tmp), .digit2(digit2_tmp), .digit3(digit3_tmp), .digit4(digit4_tmp),
        .result1(result1), .result2(result2), .result3(result3), .result4(result4),
        .clk(clk), .rst(rst), .show_en(show_en), .state(state), .ssd_ctl(ssd_ctl), .BCD(BCD));
          
endmodule
