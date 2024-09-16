`timescale 1ns / 1ps
`define MD 1'b0
`define YEAR 1'b1
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
`define SS_F 8'b10001110   

module ssd(
    input dip,
    input clk,
    input rst,
    input [3:0] day1,  //计
    input [3:0] day2,   //计
    input [3:0] month1,  //计
    input [3:0] month2,   //计
    input [3:0] year1, //计
    input [3:0] year2,  //计
    output reg [3:0] ssd_ctl,
    output reg [7:0] BCD
    );
    
reg [3:0] BCD_tmp;
reg [19:0] cnt;
reg [19:0] cnt_tmp;
wire [1:0] sel;

/* 20-bit counter for contral */
always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 19'b00;
    else
        cnt <= cnt_tmp;

always @ (cnt)
    cnt_tmp <= cnt+1;
    
assign sel = {cnt[19], cnt[18]};

/* 街ㄓ陪ボ */
always @*
    if (dip == `MD)
    begin
        case(sel)
            2'b00: ssd_ctl = 4'b1110;
            2'b01: ssd_ctl = 4'b1101;
            2'b10: ssd_ctl = 4'b1011;
            2'b11: ssd_ctl = 4'b0111;
            default: ssd_ctl = 4'b1111;
        endcase
    end
    else if (dip == `YEAR)
    begin
        case(sel)
            2'b00: ssd_ctl = 4'b0111;
            2'b01: ssd_ctl = 4'b1011;
            default: ssd_ctl = 4'b1111;
        endcase
    end

/* dip-switch for year or month-day display & 璶陪ボ街 */
always @*
    if (dip == `MD)
    begin
        case(sel)
            2'b00: BCD_tmp = month1;
            2'b01: BCD_tmp = month2;
            2'b10: BCD_tmp = day1;
            2'b11: BCD_tmp = day2;
            default: BCD_tmp = 4'b0000;
        endcase
    end
    else
    begin
        case(sel)
            2'b00: BCD_tmp = year2;
            2'b01: BCD_tmp = year1;
            2'b10: BCD_tmp = year2;
            2'b11: BCD_tmp = year1;
            default: BCD_tmp = 4'b0000;
        endcase
    end
    
/* 计 */
always @(BCD_tmp)
   if (sel == 2'b00)
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
    else if (sel == 2'b01)
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
    else if (sel == 2'b10)
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
    else if (sel == 2'b11)
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
