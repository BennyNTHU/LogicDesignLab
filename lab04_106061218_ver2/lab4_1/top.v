`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    output [7:0] f
    );
    
wire clk_1Hz;

freq_div U0 (.clk(clk), .rst(rst), .signal(clk_1Hz));
shifter U1 (.clk(clk_1Hz), .rst(rst), .f(f));

endmodule
