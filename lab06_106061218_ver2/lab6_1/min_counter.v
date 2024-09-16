`timescale 1ns / 1ps

module min_counter(
    input clk,
    input rst,
    input [5:0] limit,
    input start,
    output reg carry,   //進位值,也是hour_counter的clock
    output [3:0] min1,  //十位數
    output [3:0] min2   //個位數
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
    if (limit == min)  //如果數到上限
    begin
        min_tmp = 0;  //重置min
        carry = 0; //在這個clock當下先不進位
        flag_tmp = 1; //準備要改變下一個counter的clock
    end
    else    //如果還沒數到上限
    begin
        if (flag == 1)  //但clock要反相了
        begin
            min_tmp = min + 1;   //繼續數
            carry = 1; //進位
            flag_tmp = 0;  //下一回不必把下一個counter的clock反相
        end 
        else //還沒數完且clock還不用反相
        begin
            min_tmp = min + 1;   //同樣要繼續數
            carry = 0; //但不進位
            flag_tmp = 0; //下一個counter的clock已經改變過了
        end
    end

assign min1 = min/10;
assign min2 = min%10;

endmodule