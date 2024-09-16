`timescale 1ns / 1ps

module lab2_1 (input x,
           input y,
           input cin,
           output cout,
           output s
           );

assign s = x^y^cin;
assign cout =  (cin&(x^y)) | (x&y);

endmodule
