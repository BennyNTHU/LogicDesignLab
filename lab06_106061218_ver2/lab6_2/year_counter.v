`timescale 1ns / 1ps

module year_counter(
    input clk,
    input rst,
    input [6:0] limit,
    input start,
    output [3:0] year1, //�Q���
    output [3:0] year2  //�Ӧ��
    );

reg [6:0] year;
reg [6:0] year_tmp;

always @(posedge clk or negedge rst )   //DFF
    if (~rst) 
        year <= start;
    else 
        year <= year_tmp;
        
always @*
    if (limit == year)  //�p�G�ƨ�W��
        year_tmp = 0;  //���myear
    else    //�p�G�٨S�ƨ�W��
        year_tmp = year + 1;   //�~���

assign year1 = year / 10;
assign year2 = year % 10;

endmodule
