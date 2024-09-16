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
    input [8:0] last_change,
    input clk,
    input rst,
    output [3:0] ssd_ctl,
    output reg [7:0] BCD
    );

wire [7:0] last_change1;

assign last_change1 = {last_change[7:0]};
assign ssd_ctl = 4'b1110;

always @(last_change)
    case (last_change)
        8'h70: BCD = `SS_0;
        8'h69: BCD = `SS_1;
        8'h72: BCD = `SS_2;
        8'h7A: BCD = `SS_3;
        8'h6B: BCD = `SS_4;
        8'h73: BCD = `SS_5;
        8'h74: BCD = `SS_6;
        8'h6C: BCD = `SS_7;
        8'h75: BCD = `SS_8;
        8'h7d: BCD = `SS_9;
        8'h1c: BCD = `SS_A;
        8'h1b: BCD = `SS_S;
        8'h3a: BCD = `SS_M;
        8'h5a: BCD = `SS_BLANK;
        default: BCD = `SS_F;
    endcase

endmodule
