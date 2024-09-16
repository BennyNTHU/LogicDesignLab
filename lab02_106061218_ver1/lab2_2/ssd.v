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

module ssd(
    input [3:0] dip,
    output [3:0] LED,
    output [3:0] ssd_ctl,
    output reg [7:0] BCD
    );

assign LED = dip;
assign ssd_ctl = 4'b0000;

always @*
    case (dip)
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
        default BCD = 8'b01110001;
    endcase
    
endmodule
