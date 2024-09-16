`timescale 1ns / 1ps

module calculator(
    input [3:0] digit1,
    input [3:0] digit2,
    output [3:0] digit3,
    output [3:0] digit4
    );

wire [4:0] sum;

assign sum = digit1 + digit2;
assign digit3 = sum / 10;
assign digit4 = sum % 10;

endmodule
