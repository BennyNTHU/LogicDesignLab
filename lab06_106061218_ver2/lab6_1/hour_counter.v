`timescale 1ns / 1ps

module hour_counter(
    input clk,
    input rst,
    input [4:0] limit,
    input start,
    output [3:0] hour1, //�Q���
    output [3:0] hour2  //�Ӧ��
    );

reg [4:0] hour;
reg [4:0] hour_tmp;

always @(posedge clk or negedge rst )   //DFF
    if (~rst) 
        hour <= start;
    else 
        hour <= hour_tmp;
        
always @*
    if (limit == hour)  //�p�G�ƨ�W��
        hour_tmp <= 0;  //���mhour
    else    //�p�G�٨S�ƨ�W��
        hour_tmp <= hour + 1;   //�~���

assign hour1 = hour/10;
assign hour2 = hour%10;

endmodule
