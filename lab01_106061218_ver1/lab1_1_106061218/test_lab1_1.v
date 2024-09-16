`timescale 1ns / 1ps
module test_lab1_1;

wire COUT, S;
reg X, Y, CIN;

lab1_1 U0(.cout(COUT), .x(X), .y(Y), .cin(CIN), .s(S));

initial
begin
CIN = 0; X = 0; Y = 0;
#100 CIN = 0; X = 0; Y = 1; 
#100 CIN = 0; X = 1; Y = 0; 
#100 CIN = 0; X = 1; Y = 1; 
#100 CIN = 1; X = 0; Y = 0; 
#100 CIN = 1; X = 0; Y = 1; 
#100 CIN = 1; X = 1; Y = 0; 
#100 CIN = 1; X = 1; Y = 1;
end 

endmodule
