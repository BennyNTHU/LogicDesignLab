`timescale 1ns / 1ps

module day_counter(
    input clk,
    input rst,
    input [4:0] limit,
    input start,
    output reg carry,   //�i���,�]�Omonth_counter��clock
    output [3:0] day1,  //�Q���
    output [3:0] day2   //�Ӧ��
    );

reg [4:0] day;
reg [4:0] day_tmp;
reg flag, flag_tmp;

always @(posedge clk or negedge rst )
    if (~rst) 
        flag <= 0;
    else 
        flag <= flag_tmp;
        
always @(posedge clk or negedge rst)   //DFF
    if (~rst) 
        day <= start;
    else
        day <= day_tmp;
   
always @*
    if (limit == day)  //�p�G�ƨ�W��
    begin
        day_tmp = start;  //���mday
        carry = 0; //�b�o��clock��U�����i��
        flag_tmp = 1; //�ǳƭn���ܤU�@��counter��clock
    end
    else    //�p�G�٨S�ƨ�W��
    begin
        if (flag == 1)  //��clock�n�ϬۤF
        begin
            day_tmp = day + 1;   //�~���
            carry = 1; //�i��
            flag_tmp = 0;  //�U�@�^������U�@��counter��clock�Ϭ�
        end 
        else //�٨S�Ƨ��Bclock�٤��ΤϬ�
        begin
            day_tmp = day + 1;   //�P�˭n�~���
            carry = 0; //�����i��
            flag_tmp = 0; //�U�@��counter��clock�w�g���ܹL�F
        end
    end

assign day1 = day / 10;
assign day2 = day % 10;

endmodule