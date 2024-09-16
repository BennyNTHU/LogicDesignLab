`timescale 1ns / 1ps

module note_ctrl(
    input clk,
    input rst_n,
    input [8:0] last_change,
    output reg [21:0]note_out
    );
        
always @*
    case (last_change)
        // down row, begin with Z
        8'h1A: note_out = 22'd227273;    //A
        8'h22: note_out = 22'd204082;    //B
        8'h21: note_out = 22'd191571;    //C
        8'h2A: note_out = 22'd170648;    //D
        8'h32: note_out = 22'd151515;    //E
        8'h31: note_out = 22'd143266;    //F
        8'h3A: note_out = 22'd127551;    //G
        8'h41: note_out = 22'd113636;    //A
        8'h49: note_out = 22'd101215;    //B
        //first row, begin with E
        8'h24: note_out = 22'd95420;    //C
        8'h2D: note_out = 22'd85034;    //D
        8'h2C: note_out = 22'd75758;    //E
        8'h35: note_out = 22'd71633;    //F
        8'h3C: note_out = 22'd63776;    //G
        8'h43: note_out = 22'd56818;    //A
        8'h44: note_out = 22'd50607;    //B
        default: note_out = 22'd000000;
    endcase

endmodule
