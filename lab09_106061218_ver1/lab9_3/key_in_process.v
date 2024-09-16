`timescale 1ns / 1ps
`define KEY_IN_DIGIT1 3'b000
`define KEY_IN_DIGIT2 3'b001
`define KEY_IN_MODE 3'b010
`define KEY_IN_DIGIT3 3'b011
`define KEY_IN_DIGIT4 3'b100
`define PRE_CALCULATE 3'b101
`define CALCULATE 3'b110
`define MODE_PLUS 12
`define MODE_MINUS 13
`define MODE_MULTIPLY 14
`define ENTER 15

module key_in_process(
    input rst,
    input clk,
    input [511:0] key_down,
    input [3:0] digit,
    input [8:0] last_change,
    output reg [2:0] state,
    output reg [3:0] mode,
    output reg [3:0] digit1,digit1_tmp,
    output reg [3:0] digit2,digit2_tmp,
    output reg [3:0] digit3,digit3_tmp,
    output reg [3:0] digit4,digit4_tmp,
    output reg show_en
    );

reg [2:0] next_state;
reg [3:0] mode_tmp;
reg show_en_tmp;

always @(posedge key_down[last_change] or posedge rst)
    if (rst)
        state <= 3'b000;
    else
        state <= next_state;
  
always @(posedge key_down[last_change] or posedge rst)
    if (rst)
    begin
        digit1 <= 0;
        digit2 <= 0;
        digit3 <= 0;
        digit4 <= 0;
        mode <= 0;
        show_en <= 0;
    end
    else
    begin
        digit1 <= digit1_tmp;
        digit2 <= digit2_tmp;
        digit3 <= digit3_tmp;
        digit4 <= digit4_tmp;
        mode <= mode_tmp;
        show_en <= show_en_tmp;
    end
    
always @*
    case (state)
        `KEY_IN_DIGIT1:
            if ((digit >= 0) && (digit <= 9))
                next_state = `KEY_IN_DIGIT2;
            else
                next_state = `KEY_IN_DIGIT1;
        `KEY_IN_DIGIT2:
            if ((digit >= 0) && (digit <= 9))
                next_state = `KEY_IN_MODE;
            else
                next_state = `KEY_IN_DIGIT2;
        `KEY_IN_MODE:
            if ((digit == `MODE_PLUS) || (digit == `MODE_MINUS) || (digit == `MODE_MULTIPLY))
                next_state = `KEY_IN_DIGIT3;
            else
                next_state = `KEY_IN_MODE;
        `KEY_IN_DIGIT3:
            if ((digit >= 0) && (digit <= 9))
                next_state = `KEY_IN_DIGIT4;
            else
                next_state = `KEY_IN_DIGIT3;
        `KEY_IN_DIGIT4:
            if ((digit >= 0) && (digit <= 9))
                next_state = `PRE_CALCULATE;
            else
                next_state = `KEY_IN_DIGIT4;
        `PRE_CALCULATE:
            if (digit == `ENTER)
                next_state = `CALCULATE;
            else
                next_state = `PRE_CALCULATE;
        `CALCULATE:
             if (digit == `ENTER)
                next_state = `KEY_IN_DIGIT1;
             else
                next_state = `CALCULATE;
        default:
            next_state = `PRE_CALCULATE;
    endcase
        
always @*
    case (state)
        `KEY_IN_DIGIT1:
            if ((digit >= 0) && (digit <= 9))
                digit1_tmp = digit;
            else
                digit1_tmp = 0;
        `KEY_IN_DIGIT2:
            if ((digit >= 0) && (digit <= 9))
                digit2_tmp = digit;
            else
                digit2_tmp = 0;
        `KEY_IN_MODE:
            if ((digit == `MODE_PLUS) || (digit == `MODE_MINUS) || (digit == `MODE_MULTIPLY))
                mode_tmp = digit;
            else 
                mode_tmp = 0;
        `KEY_IN_DIGIT3:
            if ((digit >= 0) && (digit <= 9))
                digit3_tmp = digit;
            else
                digit3_tmp = 0;
        `KEY_IN_DIGIT4:
            if ((digit >= 0) && (digit <= 9))
                digit4_tmp = digit;
            else
                digit4_tmp = 0;
        `PRE_CALCULATE:;
        `CALCULATE:;
        default:
        begin
            digit1_tmp = 0;
            digit2_tmp = 0;
            digit3_tmp = 0;
            digit4_tmp = 0;
            mode_tmp = 0;
            show_en_tmp = 0;
        end   
    endcase
    
endmodule
