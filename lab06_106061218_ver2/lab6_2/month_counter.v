`timescale 1ns / 1ps

module month_counter(
    input clk,
    input rst,
    input [4:0] limit,
    input start,
    output reg carry,   //進位值,也是year_counter的clock
    output [3:0] month1,  //十位數
    output [3:0] month2   //個位數
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
    if (limit == month)  //如果數到上限
    begin
        month_tmp = start;  //重置month
        carry = 0; //在這個clock當下先不進位
        flag_tmp = 1; //準備要改變下一個counter的clock
    end
    else    //如果還沒數到上限
    begin
        if (flag == 1)  //但clock要反相了
        begin
            month_tmp = month + 1;   //繼續數
            carry = 1; //進位
            flag_tmp = 0;  //下一回不必把下一個counter的clock反相
        end 
        else //還沒數完且clock還不用反相
        begin
            month_tmp = month + 1;   //同樣要繼續數
            carry = 0; //但不進位
            flag_tmp = 0; //下一個counter的clock已經改變過了
        end
    end

assign month1 = month / 10;
assign month2 = month % 10;

endmodule