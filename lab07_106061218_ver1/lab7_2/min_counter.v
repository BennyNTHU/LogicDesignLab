`timescale 1ns / 1ps

module min_counter(
    input clk,
    input rst,
    input en,
    input [5:0] limit,
    input start,
    output reg [5:0] min,
    output [3:0] min1, //�Q���
    output [3:0] min2  //�Ӧ��
    );

reg [4:0] min_tmp;

always @(posedge clk or posedge rst )   //DFF
    if (rst) 
        min <= limit;
    else 
        min <= min_tmp;
        
always @*
    if (en == 1)
    begin
        if (start == min)  //�p�G�ƨ�U��
            min_tmp = 0;  //���mmin
        else    //�p�G�٨S�ƨ�W��
            min_tmp = min - 1;   //�~���
    end
    else
        min_tmp = min;


assign min1 = min / 10;
assign min2 = min % 10;


endmodule
