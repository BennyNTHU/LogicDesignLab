`timescale 1ns / 1ps
`define KEY_IN_DIGIT1 2'b00
`define KEY_IN_DIGIT2 2'b01
`define PRE_CALCULATE 2'b10
`define CALCULATE 2'b11
`define ENTER 15

module key_in_process(
    input rst,
    input [511:0] key_down,
    input [3:0] digit,
    input [8:0] last_change,
    output reg [3:0]digit1,
    output reg [3:0]digit2
    );

reg [1:0] state, next_state;
reg [3:0] digit1_tmp, digit2_tmp;

always @(posedge key_down[last_change] or posedge rst)
    if (rst)
        state <= 2'b00;
    else
        state <= next_state;

always @(posedge key_down[last_change] or posedge rst)
    if (rst)
    begin
        digit1 <= 0;
        digit2 <= 0;
    end
    else
    begin
        digit1 <= digit1_tmp;
        digit2 <= digit2_tmp;
    end
    
always @*
    case (state)
        `KEY_IN_DIGIT1:
            if (digit != 11)
                next_state = `KEY_IN_DIGIT2;
            else
                next_state = `KEY_IN_DIGIT1;
        `KEY_IN_DIGIT2:
            if (digit != 11)
                next_state = `CALCULATE;
            else
                next_state = `KEY_IN_DIGIT2;
        `PRE_CALCULATE:
            if (digit == `ENTER)
                next_state = `CALCULATE;
            else
                next_state = `PRE_CALCULATE;
        `CALCULATE:
            next_state = `KEY_IN_DIGIT1;
        default:
            next_state = `PRE_CALCULATE;
    endcase
        
always @*
    case (state)
        `KEY_IN_DIGIT1:
            if (digit != 11)
                digit1_tmp = digit;
            else
                digit1_tmp = 0;
        `KEY_IN_DIGIT2:
            if (digit != 11)
                digit2_tmp = digit;
            else
                digit2_tmp = 0;
        `PRE_CALCULATE:;
        `CALCULATE:;
        default:
            begin
                digit1_tmp = 0;
                digit2_tmp = 0;
            end
   endcase
   
endmodule
