`timescale 1ns / 1ps

module min_counter(
    input clk,
    input rst,
    input [5:0] limit,
    input start,
    output reg carry,   //�i���,�]�Ohour_counter��clock
    output [3:0] min1,  //�Q���
    output [3:0] min2   //�Ӧ��
    );

reg [5:0] min;
reg [5:0] min_tmp;
reg flag, flag_tmp;

always @(posedge clk or negedge rst )
    if (~rst) 
        flag <= start;
    else 
        flag  <= flag_tmp;
        
always @(posedge clk or negedge rst)   //DFF
    if (~rst) 
        min <= start;
    else
        min <= min_tmp;
   
always @*
    if (limit == min)  //�p�G�ƨ�W��
    begin
        min_tmp = 0;  //���mmin
        carry = 0; //�b�o��clock��U�����i��
        flag_tmp = 1; //�ǳƭn���ܤU�@��counter��clock
    end
    else    //�p�G�٨S�ƨ�W��
    begin
        if (flag == 1)  //��clock�n�ϬۤF
        begin
            min_tmp = min + 1;   //�~���
            carry = 1; //�i��
            flag_tmp = 0;  //�U�@�^������U�@��counter��clock�Ϭ�
        end 
        else //�٨S�Ƨ��Bclock�٤��ΤϬ�
        begin
            min_tmp = min + 1;   //�P�˭n�~���
            carry = 0; //�����i��
            flag_tmp = 0; //�U�@��counter��clock�w�g���ܹL�F
        end
    end

assign min1 = min/10;
assign min2 = min%10;

endmodule