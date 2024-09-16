`timescale 1ns / 1ps

module hour_counter(
    input clk,
    input rst,
    input [4:0] limit,
    input start,
    output [3:0] hour1, //计
    output [3:0] hour2  //计
    );

reg [4:0] hour;
reg [4:0] hour_tmp;

always @(posedge clk or negedge rst )   //DFF
    if (~rst) 
        hour <= start;
    else 
        hour <= hour_tmp;
        
always @*
    if (limit == hour)  //狦计
        hour_tmp <= 0;  //竚hour
    else    //狦临⊿计
        hour_tmp <= hour + 1;   //膥尿计

assign hour1 = hour/10;
assign hour2 = hour%10;

endmodule
