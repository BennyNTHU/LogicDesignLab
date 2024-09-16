`timescale 1ns / 1ps

module decide(  //決定每月有幾天
    input [3:0] month1,
    input [3:0] month2,
    output reg [4:0] day_limit
    );
    
wire [3:0] month = 10 * month1 + month2;

always @*
case (month)
    1: day_limit = 31;
    2: day_limit = 28;
    3: day_limit = 31;
    4: day_limit = 30;
    5: day_limit = 31;
    6: day_limit = 30;
    7: day_limit = 31;
    8: day_limit = 31;
    9: day_limit = 30;
    10: day_limit = 31;
    11: day_limit = 30; 
    12: day_limit = 31;
    default: day_limit = 40;    //Good for debug
endcase
     
endmodule
