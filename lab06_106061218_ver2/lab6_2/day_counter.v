`timescale 1ns / 1ps

module day_counter(
    input clk,
    input rst,
    input [4:0] limit,
    input start,
    output reg carry,   //進位值,也是month_counter的clock
    output [3:0] day1,  //十位數
    output [3:0] day2   //個位數
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
    if (limit == day)  //如果數到上限
    begin
        day_tmp = start;  //重置day
        carry = 0; //在這個clock當下先不進位
        flag_tmp = 1; //準備要改變下一個counter的clock
    end
    else    //如果還沒數到上限
    begin
        if (flag == 1)  //但clock要反相了
        begin
            day_tmp = day + 1;   //繼續數
            carry = 1; //進位
            flag_tmp = 0;  //下一回不必把下一個counter的clock反相
        end 
        else //還沒數完且clock還不用反相
        begin
            day_tmp = day + 1;   //同樣要繼續數
            carry = 0; //但不進位
            flag_tmp = 0; //下一個counter的clock已經改變過了
        end
    end

assign day1 = day / 10;
assign day2 = day % 10;

endmodule