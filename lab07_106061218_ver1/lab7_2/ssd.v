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
`define SS_F 8'b10001110   

module ssd(
    input clk,
    input rst,
    input lap,
    input dip,
    input [3:0] sec1,
    input [3:0] sec2,
    input [3:0] min1,
    input [3:0] min2,
    input [3:0] limit_min1, limit_min2, limit_hour1, limit_hour2,
    output reg [3:0] ssd_ctl,
    output reg [7:0] BCD
    );
    
reg [3:0] BCD_tmp;
reg [19:0] cnt;
reg [19:0] cnt_tmp;
wire [1:0] sel;
reg [3:0] digit1, digit2, digit3, digit4;

always @(posedge clk or posedge rst)
    if (rst)
        cnt <= 19'b00;
    else
        cnt <= cnt_tmp;

always @ (cnt)
    cnt_tmp = cnt+1;
    
assign sel = {cnt[19], cnt[18]};

always @*   //誰來顯示
    case(sel)
         2'b00: ssd_ctl = 4'b1110;
         2'b01: ssd_ctl = 4'b1101;
         2'b10: ssd_ctl = 4'b1011;
         2'b11: ssd_ctl = 4'b0111;
         default: ssd_ctl = 4'b1111;
    endcase
    
always @*   //要顯示誰
    if (dip)
        case(sel)
             2'b00: BCD_tmp = limit_min2; //sec2
             2'b01: BCD_tmp = limit_min1; //sec1
             2'b10: BCD_tmp = limit_hour2; //min2
             2'b11: BCD_tmp = limit_hour1; //min1
             default: BCD_tmp = 4'b0000;
        endcase
    else
        case(sel)
            2'b00: BCD_tmp = digit4; //sec2
            2'b01: BCD_tmp = digit3; //sec1
            2'b10: BCD_tmp = digit2; //min2
            2'b11: BCD_tmp = digit1; //min1
            default: BCD_tmp = 4'b0000;
        endcase

always @(posedge clk)
    if (~lap)
    begin
        digit1 <= min1;
        digit2 <= min2;
        digit3 <= sec1;
        digit4 <= sec2;
    end
    else
    begin
        digit1 <= digit1;
        digit2 <= digit2;
        digit3 <= digit3;
        digit4 <= digit4;
    end
        
    

//四個數字
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
