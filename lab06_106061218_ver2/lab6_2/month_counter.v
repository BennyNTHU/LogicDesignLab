`timescale 1ns / 1ps

module month_counter(
    input clk,
    input rst,
    input [4:0] limit,
    input start,
    output reg carry,   //�i���,�]�Oyear_counter��clock
    output [3:0] month1,  //�Q���
    output [3:0] month2   //�Ӧ��
    );

reg [4:0] month;
reg [4:0] month_tmp;
reg flag, flag_tmp;

always @(posedge clk or negedge rst )
    if (~rst) 
        flag <= 0;
    else 
        flag  <= flag_tmp;
        
always @(posedge clk or negedge rst)   //DFF
    if (~rst) 
        month <= start;
    else
        month <= month_tmp;
   
always @*
    if (limit == month)  //�p�G�ƨ�W��
    begin
        month_tmp = start;  //���mmonth
        carry = 0; //�b�o��clock��U�����i��
        flag_tmp = 1; //�ǳƭn���ܤU�@��counter��clock
    end
    else    //�p�G�٨S�ƨ�W��
    begin
        if (flag == 1)  //��clock�n�ϬۤF
        begin
            month_tmp = month + 1;   //�~���
            carry = 1; //�i��
            flag_tmp = 0;  //�U�@�^������U�@��counter��clock�Ϭ�
        end 
        else //�٨S�Ƨ��Bclock�٤��ΤϬ�
        begin
            month_tmp = month + 1;   //�P�˭n�~���
            carry = 0; //�����i��
            flag_tmp = 0; //�U�@��counter��clock�w�g���ܹL�F
        end
    end

assign month1 = month / 10;
assign month2 = month % 10;

endmodule