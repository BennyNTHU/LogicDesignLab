`timescale 1ns / 1ps

module year_counter(
    input clk,
    input rst,
    input [6:0] limit,
    input start,
    output [3:0] year1, //计
    output [3:0] year2  //计
    );

reg [6:0] year;
reg [6:0] year_tmp;

always @(posedge clk or negedge rst )   //DFF
    if (~rst) 
        year <= start;
    else 
        year <= year_tmp;
        
always @*
    if (limit == year)  //狦计
        year_tmp = 0;  //竚year
    else    //狦临⊿计
        year_tmp = year + 1;   //膥尿计

assign year1 = year / 10;
assign year2 = year % 10;

endmodule
