`timescale 1ns / 1ps

module sec_counter(
    input clk,
    input rst,
    input en,
    input [5:0] limit,
    input start,
    input [5:0] min,
    output reg carry,   //進位值,也是min_counter的clock
    output [3:0] sec1,  //十位數
    output [3:0] sec2   //個位數
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
        if (start == sec)  //如果數到下限
            if (min == 0)
                sec_tmp = 0;
            else
            begin
                sec_tmp = 59;  //重置
                carry = 0; //在這個clock當下先不進位
                flag_tmp = 1; //準備要改變下一個counter的clock
            end
        else    //如果還沒數到下限
        begin
            if (flag == 1)  //但clock要反相了
            begin
                sec_tmp = sec - 1;   //繼續數
                carry = 1; //進位
                flag_tmp = 0;  //下一回不必把下一個counter的clock反相
            end 
            else //還沒數完且clock還不用反相
            begin
                sec_tmp = sec - 1;   //同樣要繼續數
                carry = 0; //但不進位
                flag_tmp = 0; //下一個counter的clock已經改變過了
            end
        end
    end
    else
        sec_tmp = sec;

assign sec1 = sec / 10;
assign sec2 = sec % 10;

endmodule