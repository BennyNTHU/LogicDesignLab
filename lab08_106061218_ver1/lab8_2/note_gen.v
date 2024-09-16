`timescale 1ns / 1ps

module note_gen(
    input clk,
    input rst,
    input [21:0] note_div,
    input [15:0] volumn_up,
    input [15:0] volumn_down,
    output[15:0] audio_left,
    output [15:0] audio_right
    );

reg [21:0] clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next;

always @(posedge clk or negedge rst)
    if(~rst)
    begin
        clk_cnt <= 22'd0;
        b_clk <=1'b0;
    end
    else
    begin
        clk_cnt <= clk_cnt_next;
        b_clk <=b_clk_next;
    end
 
 always @*
    if(clk_cnt == note_div)
    begin
        clk_cnt_next = 22'd0;
        b_clk_next = ~b_clk;
    end
    else
    begin
        clk_cnt_next = clk_cnt + 1'b1;
        b_clk_next = b_clk;
    end

assign audio_left = (b_clk == 1'b0) ? volumn_down : volumn_up;
assign audio_right = (b_clk == 1'b0) ? volumn_down : volumn_up;

endmodule
