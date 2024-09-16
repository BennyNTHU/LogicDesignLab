`timescale 1ns / 1ps

module lab2_3 (
    input [3:0]  a,
    input [3:0] b,
    output [3:0] leda,
    output [3:0] ledb,
    output x
    );
    
assign leda = a;
assign ledb = b;
assign x = (a<= b) ? 0 : 1;
    
endmodule
