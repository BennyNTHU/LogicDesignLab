`timescale 1ns / 1ps

module sec_counter(
    input clk,
    input rst,
    input en,
    input [5:0] limit,
    input start,
    input [5:0] min,
    output reg carry,   //�i���,�]�Omin_counter��clock
    output [3:0] sec1,  //�Q���
    output [3:0] sec2   //�Ӧ��
    );

reg [5:0] sec;
reg [5:0] sec_tmp;
reg flag, flag_tmp;

always @(posedge clk or posedge rst )
    if (rst) 
        flag <= start;
    else 
        flag <= flag_tmp;
        
always @(posedge clk or posedge rst)   //DFF
    if (rst) 
        sec <= limit;
    else
        sec <= sec_tmp;
   
always @(sec)
    if (en == 1)
    begin
        if (start == sec)  //�p�G�ƨ�U��
            if (min == 0)
                sec_tmp = 0;
            else
            begin
                sec_tmp = 59;  //���m
                carry = 0; //�b�o��clock��U�����i��
                flag_tmp = 1; //�ǳƭn���ܤU�@��counter��clock
            end
        else    //�p�G�٨S�ƨ�U��
        begin
            if (flag == 1)  //��clock�n�ϬۤF
            begin
                sec_tmp = sec - 1;   //�~���
                carry = 1; //�i��
                flag_tmp = 0;  //�U�@�^������U�@��counter��clock�Ϭ�
            end 
            else //�٨S�Ƨ��Bclock�٤��ΤϬ�
            begin
                sec_tmp = sec - 1;   //�P�˭n�~���
                carry = 0; //�����i��
                flag_tmp = 0; //�U�@��counter��clock�w�g���ܹL�F
            end
        end
    end
    else
        sec_tmp = sec;

assign sec1 = sec / 10;
assign sec2 = sec % 10;

endmodule