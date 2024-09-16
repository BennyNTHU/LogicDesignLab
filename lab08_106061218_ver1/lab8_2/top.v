`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    input Do,
    input Re,
    input Mi,
    input up_in,
    input down_in,
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
wire [3:0] volume;

note_ctrl U0 (.clk(clk), .rst(rst), .Do(Do), .Re(Re), .Mi(Mi), .note_out(note));

volumn_ctrl U1 (.clk(clk), .rst(rst), .up_in(up_in), .down_in(down_in), 
                  .volumn_down(volumn_down), .volumn_up(volumn_up), .out(volume));
                  
note_gen U2 (.clk(clk), .rst(rst), .note_div(note), .volumn_down(volumn_down), .volumn_up(volumn_up),
             .audio_left(audio_in_left), .audio_right(audio_in_right));

read U3 (.clk(clk), .rst(rst), .in_reg({audio_in_left,audio_in_right}), .so(audio_sdin),
        .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck));

ssd U4 (.clk(clk), .rst(rst), .volume(volume), .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule
