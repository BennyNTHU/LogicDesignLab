`timescale 1ns / 1ps

module top(
    input clk,
    input rst_n,
    inout PS2_DATA,
    inout PS2_CLK,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    output [3:0] ssd_ctl,
    output [7:0] BCD
    );

wire [15:0] audio_in_left;
wire [15:0] audio_in_right;
wire [21:0] note;
wire [15:0] volumn_down;
wire [15:0] volumn_up;
wire [511:0] key_down;
wire [8:0] last_change;
wire key_valid;

KeyboardDecoder U0 (.clk(clk), .rst(rst), .key_down(key_down), .last_change(last_change),
                   .key_valid(key_valid), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK));  

note_ctrl U1 (.clk(clk), .rst_n(rst_n), .note_out(note), .last_change(last_change));

note_gen U2 (.clk(clk), .rst_n(rst_n), .note_div(note), .volumn_down(16'h8000), .volumn_up(16'h7FFF),
             .audio_left(audio_in_left), .audio_right(audio_in_right));

read U3 (.clk(clk), .rst_n(rst_n), .in_reg({audio_in_left,audio_in_right}), .so(audio_sdin),
        .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck));

ssd U4 (.clk(clk), .rst(rst_n), .last_change(last_change), .ssd_ctl(ssd_ctl), .BCD(BCD));
 
endmodule
