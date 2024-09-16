`timescale 1ns / 1ps
`define SS_A 8'b00010001
`define SS_B 8'b00000001
`define SS_C 8'b01100011
`define SS_D 8'b00000011
`define SS_E 8'b01100001
`define SS_F 8'b01110001
`define SS_G 8'b01000001
`define SS_BLANK 8'b11111111

module ssd(
    input clk,
    input rst,
    input [8:0] last_change,
    output [3:0] ssd_ctl,
    output reg [7:0] BCD
    );

assign ssd_ctl = 4'b1110;

always @*
    case (last_change)
        // down row, begin with Z
        8'h1A: BCD = `SS_A;    //A
        8'h22: BCD = `SS_B;    //B
        8'h21: BCD = `SS_C;    //C
        8'h2A: BCD = `SS_D;    //D
        8'h32: BCD = `SS_E;    //E
        8'h31: BCD = `SS_F;    //F
        8'h3A: BCD = `SS_G;    //G
        8'h41: BCD = `SS_A;    //A
        8'h49: BCD = `SS_B;    //B
        //first row, begin with E
        8'h24: BCD = `SS_C;    //C
        8'h2D: BCD = `SS_D;    //D
        8'h2C: BCD = `SS_E;    //E
        8'h35: BCD = `SS_F;    //F
        8'h3C: BCD = `SS_G;    //G
        8'h43: BCD = `SS_A;    //A
        8'h44: BCD = `SS_B;    //B
        default: BCD = `SS_BLANK;
    endcase
        
endmodule