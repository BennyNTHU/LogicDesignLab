`timescale 1ns / 1ps

module counter(rst, clk, bit30, freeze);  //Down Counter的部分

/* Global input/Output */
input rst;
input clk;
input freeze; //是否要暫停

/* Down Counter */
output reg [4:0] bit30;
reg [4:0] bit_tmp;

always @(posedge clk or negedge rst)
    if (~rst)
        bit30 <= 5'd30;
    else
        bit30 <= bit_tmp;

//按鈕造成暫停的部分
always @*
    if (freeze == 1'b1) begin  //從FSM傳回來,按下去就暫停,沒按的話繼續數   
        bit_tmp = bit30 - 1;
        if (bit30 == 5'b00000)
            bit_tmp = 5'b00000;
    end
    else 
        bit_tmp = bit30;

endmodule 
