`timescale 1ns / 1ps
`define KEY_IN_DIGIT1 1'b0
`define KEY_IN_DIGIT2 1'b1

module FSM(
    input key_valid,
    input rst,
    input [8:0] last_change,
    input [3:0] digit,  //鍵盤輸入
    output reg [3:0] digit1, //被加數
    output reg [3:0] digit2  //加數
    );
    
reg [1:0] key_in_count;
reg [1:0] key_in_count_temp;

always @(posedge key_valid or posedge rst)
    if (rst)
        key_in_count <= 0;
    else
        key_in_count <= key_in_count_temp;
        
always @*
    if (digit != 11)
        key_in_count_temp = key_in_count + 1;
    else if (key_in_count == 2'b10)
         key_in_count_temp <= 2'b00;
    else
         key_in_count_temp = key_in_count;
   
always @*
    case (key_in_count)
        2'b00:  begin 
                    digit1 = 0; 
                    digit2 = 0;
                end  
        2'b01:  begin 
                    digit1 = digit; 
                    digit2 = 0;
                end
        2'b10:  begin 
                    digit1 = digit1; 
                    digit2 = digit;
                end
        default:begin 
                    digit1 = digit1; 
                    digit2 = digit2;
                end
    endcase    
 
endmodule
