`timescale 1ns / 1ps

module top(
    input clk,
    input rst_n,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );

wire [15:0] audio_in_left;
wire [15:0] audio_in_right;
wire [21:0] note;
wire [15:0] volumn_down;
wire [15:0] volumn_up;

note_ctrl U0 (.clk(clk), .rst_n(rst_n), .note_out(note));
                  
note_gen U2 (.clk(clk), .rst_n(rst_n), .note_div(note), .volumn_down(16'hA800), .volumn_up(16'h57FF),
             .audio_left(audio_in_left), .audio_right(audio_in_right));

read U3 (.clk(clk), .rst_n(rst_n), .in_reg({audio_in_left,audio_in_right}), .so(audio_sdin),
        .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck));

endmodule
