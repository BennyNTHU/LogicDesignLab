`timescale 1ns / 1ps

`define SS_N 8'b10101011
`define SS_T 8'b10000111
`define SS_H 8'b10001001
`define SS_U 8'b11000001
`define SS_E 8'b10000110
`define SS_F 8'b10001110   

module ssd_shifter(
    input clk,
    input rst,
    output reg [7:0] cur_display,
    output reg [3:0] ssd_ctl
    );

reg [19:0] cnt;
reg [19:0] cnt_tmp;
wire [1:0] ab_sel;
reg [7:0] ee1, ee2, ee3, ee4, ee5, ee6;

always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 19'b00;
    else
        cnt <= cnt_tmp;

always @ (cnt)
    cnt_tmp <= cnt+1;

assign ab_sel = {cnt[19], cnt[18]};

always @(ab_sel)
    case (ab_sel)
        2'b00:  cur_display = ee1;
        2'b01:  cur_display = ee2;
        2'b10:  cur_display = ee3;
        2'b11:  cur_display = ee4;
        default: cur_display = `SS_F;
    endcase

always @(ab_sel)
     case (ab_sel)
        2'b00: ssd_ctl = 4'b1110;
        2'b01: ssd_ctl = 4'b1101;
        2'b10: ssd_ctl = 4'b1011;
        2'b11: ssd_ctl = 4'b0111;
        default: ssd_ctl = 4'b1111;
     endcase
     
always@ (posedge clk or negedge rst)
    if (~rst)
    begin
        ee1 <= `SS_N;
        ee2 <= `SS_T;
        ee3 <= `SS_H;
        ee4 <= `SS_U;
        ee5 <= `SS_E;
        ee6 <= `SS_E;
    end
    else
    begin
        ee6 <= ee1;
        ee1 <= ee2;
        ee2 <= ee3;
        ee3 <= ee4;
        ee4 <= ee5;
        ee5 <= ee6;
    end
               
endmodule
