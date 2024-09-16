`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );

wire [15:0]audio_in_left;
wire [15:0]audio_in_right;

note_gen U0 (.clk(clk), .rst(rst), .note_div(22'd191571),
             .audio_left(audio_in_left), .audio_right(audio_in_right));

read U1 (.clk(clk), .rst(rst), .in_reg({audio_in_left,audio_in_right}),
         .so(audio_sdin), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck));

endmodule

