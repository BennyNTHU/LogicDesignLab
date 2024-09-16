`timescale 1ns / 1ps

module counter(rst, clk, bit30, freeze);  //Down Counter������

/* Global input/Output */
input rst;
input clk;
input freeze; //�O�_�n�Ȱ�

/* Down Counter */
output reg [4:0] bit30;
reg [4:0] bit_tmp;

always @(posedge clk or negedge rst)
    if (~rst)
        bit30 <= 5'd30;
    else
        bit30 <= bit_tmp;

//���s�y���Ȱ�������
always @*
    if (freeze == 1'b1) begin  //�qFSM�Ǧ^��,���U�h�N�Ȱ�,�S�������~���   
        bit_tmp = bit30 - 1;
        if (bit30 == 5'b00000)
            bit_tmp = 5'b00000;
    end
    else 
        bit_tmp = bit30;

endmodule 
