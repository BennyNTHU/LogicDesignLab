`timescale 1ns / 1ps

module FSM(
    input in,  //input control
    input clk,
    input rst,
    output reg count_enable,
    output current_state
    );

reg state, next_state;
    
//FSM state
always@*
    case(state)
        1'b0:
            if(in)
            begin
                next_state = 1'b1;
                count_enable = 1'b1;
            end
            else
            begin
                next_state = 1'b0;
                count_enable = 1'b0;
            end
        1'b1:
            if(in)
            begin
                next_state = 1'b0;
                count_enable = 1'b0;
            end
            else
            begin
                next_state = 1'b1;
                count_enable = 1'b1;
            end
            default:
            begin
                next_state = 1'b0;
                count_enable = 1'b0;
            end
    endcase
    
//current state display    
assign current_state = state;
        
//FSM state transition
always@(posedge clk or posedge rst)
    if(rst)
        state <= 1'b0;
    else
        state <= next_state;
    
endmodule
