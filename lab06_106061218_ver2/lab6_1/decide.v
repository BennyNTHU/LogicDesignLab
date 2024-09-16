`timescale 1ns / 1ps
`define AP 1'b1
`define _24 1'b0

module decide(
    input clk,
    input rst,
    input dip,
    input [3:0] hour1_tmp, 
    input [3:0] hour2_tmp,
    output reg [3:0] hour1,
    output reg [3:0] hour2
    );

wire [4:0] hour;   

assign hour = hour1_tmp * 10 + hour2_tmp;

always @*
    if (hour > 12)
    begin
        if (dip == `AP)
        begin
            hour1 = (hour - 12) / 10;
            hour2 = (hour - 12) % 10;
        end
        else if (dip == `_24)
        begin
            hour1 = hour1_tmp;
            hour2 = hour2_tmp;
        end
    end
    else
    begin
        hour1 = hour1_tmp;
        hour2 = hour2_tmp;
    end
                
endmodule
