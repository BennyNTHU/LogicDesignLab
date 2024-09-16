`timescale 1ns / 1ps

module note_ctrl(
    input clk,
    input rst,
    input Do,
    input Re,
    input Mi,
    output reg [21:0]note_out
    );

wire Do_tmp;
wire Re_tmp;
wire Mi_tmp;

always @*
    if(Do)
        note_out = 22'd191571;
    else if(Re)
        note_out = 22'd170648;
    else if(Mi)
        note_out = 22'd151515;
    else
        note_out = 22'd000000;
    
endmodule
