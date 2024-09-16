`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    output [7:0] f
    );

wire clk_1Hz;
wire [7:0] random;

freq_div U0 (.clk(clk), .rst(rst), .signal(clk_1Hz));
random_gen U1 (.clk(clk), .rst(rst), .random(random));
shifter U2 (.clk(clk_1Hz), .rst(rst), .random(random), .f(f));

endmodule
