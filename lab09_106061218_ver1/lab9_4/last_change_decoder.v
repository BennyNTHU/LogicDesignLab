`timescale 1ns / 1ps
`define Capslock_enable 1'b1
`define Capslock_disable 1'b0
`define Capslock 8'h58
`define KEY_A 8'h1C
`define KEY_B 8'h32
`define KEY_C 8'h21
`define KEY_D 8'h23
`define KEY_E 8'h24
`define KEY_F 8'h2B
`define KEY_G 8'h34
`define KEY_H 8'h33
`define KEY_I 8'h43
`define KEY_J 8'h3B
`define KEY_K 8'h42
`define KEY_L 8'h4B
`define KEY_M 8'h3A
`define KEY_N 8'h31
`define KEY_O 8'h44
`define KEY_P 8'h4D
`define KEY_Q 8'h15
`define KEY_R 8'h2D
`define KEY_S 8'h1B
`define KEY_T 8'h2C
`define KEY_U 8'h3C
`define KEY_V 8'h2A
`define KEY_W 8'h1D
`define KEY_X 8'h22
`define KEY_Y 8'h35
`define KEY_Z 8'h1A
`define ASCII_A 8'h41   // Capital's ASCII code
`define ASCII_B 8'h42
`define ASCII_C 8'h43
`define ASCII_D 8'h44
`define ASCII_E 8'h45
`define ASCII_F 8'h46
`define ASCII_G 8'h47
`define ASCII_H 8'h48
`define ASCII_I 8'h49
`define ASCII_J 8'h4A
`define ASCII_K 8'h4B
`define ASCII_L 8'h4C
`define ASCII_M 8'h4D
`define ASCII_N 8'h4E
`define ASCII_O 8'h4F
`define ASCII_P 8'h50
`define ASCII_Q 8'h51
`define ASCII_R 8'h52
`define ASCII_S 8'h53
`define ASCII_T 8'h54
`define ASCII_U 8'h55
`define ASCII_V 8'h56
`define ASCII_W 8'h57
`define ASCII_X 8'h58
`define ASCII_Y 8'h59
`define ASCII_Z 8'h5A

module last_change_decoder(
    input clk,
    input rst,
    input [511:0] key_down,
    input [8:0] last_change,
    output [3:0] ASCII_1,
    output [3:0] ASCII_2,
    output [3:0] ASCII_3
    );
    
reg state;
reg next_state;
wire [7:0] ASCII;
reg [7:0] ASCII_temp;

always @(posedge key_down[last_change] or posedge rst)
    if (rst)
        state <= 0;
    else
        state <= next_state;
        
always @*
    case (state)
        `Capslock_disable:
            if (last_change == `Capslock)
                next_state = `Capslock_enable;
            else
                next_state = `Capslock_disable;
        `Capslock_enable:
            if (last_change == `Capslock)
                next_state = `Capslock_disable;
            else
                next_state = `Capslock_enable;
         default:
            next_state = `Capslock_disable;
    endcase

always @*
    case (last_change)
        `KEY_A: ASCII_temp = `ASCII_A;
        `KEY_B: ASCII_temp = `ASCII_B;
        `KEY_C: ASCII_temp = `ASCII_C;
        `KEY_D: ASCII_temp = `ASCII_D;
        `KEY_E: ASCII_temp = `ASCII_E;
        `KEY_F: ASCII_temp = `ASCII_F;
        `KEY_G: ASCII_temp = `ASCII_G;
        `KEY_H: ASCII_temp = `ASCII_H;
        `KEY_I: ASCII_temp = `ASCII_I;
        `KEY_J: ASCII_temp = `ASCII_J;
        `KEY_K: ASCII_temp = `ASCII_K;
        `KEY_L: ASCII_temp = `ASCII_L;
        `KEY_M: ASCII_temp = `ASCII_M;
        `KEY_N: ASCII_temp = `ASCII_N;
        `KEY_O: ASCII_temp = `ASCII_O;
        `KEY_P: ASCII_temp = `ASCII_P;
        `KEY_Q: ASCII_temp = `ASCII_Q;
        `KEY_R: ASCII_temp = `ASCII_R;
        `KEY_S: ASCII_temp = `ASCII_S;
        `KEY_T: ASCII_temp = `ASCII_T;
        `KEY_U: ASCII_temp = `ASCII_U;
        `KEY_V: ASCII_temp = `ASCII_V;
        `KEY_W: ASCII_temp = `ASCII_W;
        `KEY_X: ASCII_temp = `ASCII_X;
        `KEY_Y: ASCII_temp = `ASCII_Y;
        `KEY_Z: ASCII_temp = `ASCII_Z;
        default: ASCII_temp = 8'b0;
    endcase

assign ASCII = (state == `Capslock_disable) ? ASCII_temp - 32 : ASCII_temp;
assign ASCII_1 = ASCII / 100;
assign ASCII_2 = (ASCII / 10) % 10;
assign ASCII_3 = ASCII % 100;
    
endmodule