`timescale 1ns / 1ps

module top(
    input rst,
    input clk,
    input pause,
    output freeze,
    output [4:0] bit30
    );

FSM U0 (.rst(rst), .clk(clk), .pause(pause), .freeze(freeze));
counter U1 (.rst(rst), .clk(clk), .freeze(freeze), .bit30(bit30));

endmodule
