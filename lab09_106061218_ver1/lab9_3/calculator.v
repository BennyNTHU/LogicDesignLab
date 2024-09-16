`timescale 1ns / 1ps

module calculator(
    input [3:0] digit1,
    input [3:0] digit2,
    input [3:0] digit3,
    input [3:0] digit4,
    input [3:0] mode,
    input [2:0] state,
    output [3:0] result1,
    output [3:0] result2,
    output [3:0] result3,
    output [3:0] result4
    );

reg [5:0] number1, number2;
reg [14:0] product;
reg [7:0] minus;
reg [7:0] sum;
reg [14:0] result_tmp;

always @*
    if (state == 3'b110)
    begin
        number1 = 10 * digit1 + digit2;
        number2 = 10 * digit3+ digit4;
        sum = number1 + number2;
        minus = number1 - number2;
        product = number1 * number2;
    end
    else
    begin
        number1 = 0;
        number2 = 0;
        sum = 0;
        minus = 0;
        product = 0;
    end
    
always @*
    if (state == 3'b110)
        case (mode)
            12: result_tmp = sum;
            13: result_tmp = minus;
            14: result_tmp = product;
         endcase
    else
        result_tmp = sum;
        
        
assign result1 =  result_tmp / 1000;
assign result2 = (result_tmp - result1*1000) / 100;
assign result3 = (result_tmp - result1*1000 -  result2*100) / 10;
assign result4 = result_tmp % 10;

endmodule
