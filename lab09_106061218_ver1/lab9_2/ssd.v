`timescale 1ns / 1ps
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_F 8'b01110001  
`define SS_A 8'b00010001
`define SS_S 8'b01001000
`define SS_M 8'b10110001
`define SS_BLANK 8'b11111111

module ssd(
    input clk,
    input rst,
    input [3:0] digit1, digit2, digit3, digit4,
    input [8:0] last_change,
    output reg [3:0] ssd_ctl,
    output reg [7:0] BCD
    );

reg [19:0] cnt;
reg [19:0] cnt_tmp;
wire [1:0] sel;
reg [3:0] BCD_tmp;

/* 20-bit counter for contral */
always @(posedge clk or posedge rst)
    if (rst)
        cnt <= 19'b00;
    else
        cnt <= cnt_tmp;

always @ (cnt)
    cnt_tmp <= cnt+1;
    
assign sel = {cnt[19], cnt[18]};   

always @*
    case(sel)
            2'b00: ssd_ctl = 4'b1110;
            2'b01: ssd_ctl = 4'b1101;
            2'b10: ssd_ctl = 4'b1011;
            2'b11: ssd_ctl = 4'b0111;
            default: ssd_ctl = 4'b1111;
        endcase

always @*
    case(sel)
        2'b00: BCD_tmp = digit4;
        2'b01: BCD_tmp = digit3;
        2'b10: BCD_tmp = digit2;
        2'b11: BCD_tmp = digit1;
        default: BCD_tmp = 4'b0000;
    endcase

always @(BCD_tmp)
    case (BCD_tmp)
        4'd0: BCD = `SS_0;
        4'd1: BCD = `SS_1;
        4'd2: BCD = `SS_2;
        4'd3: BCD = `SS_3;
        4'd4: BCD = `SS_4;
        4'd5: BCD = `SS_5;
        4'd6: BCD = `SS_6;
        4'd7: BCD = `SS_7;
        4'd8: BCD = `SS_8;
        4'd9: BCD = `SS_9;
        default: BCD = `SS_F;
    endcase
        
endmodule