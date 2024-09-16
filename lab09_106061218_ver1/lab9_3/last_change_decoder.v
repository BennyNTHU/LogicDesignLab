`timescale 1ns / 1ps

module last_change_decoder(
    input [8:0] last_change,
    output [3:0] digit
    );

reg [3:0] BCD;

assign digit = BCD;

always @*
    case (last_change)
        8'h70: BCD = 0;
        8'h69: BCD = 1;
        8'h72: BCD = 2;
        8'h7A: BCD = 3;
        8'h6B: BCD = 4;
        8'h73: BCD = 5;
        8'h74: BCD = 6;
        8'h6C: BCD = 7;
        8'h75: BCD = 8;
        8'h7d: BCD = 9;
        8'h79: BCD = 12;
        8'h7B: BCD = 13;
        8'h7C: BCD = 14;
        8'h5A: BCD = 15;
        default: BCD = 11;
    endcase
    
endmodule
