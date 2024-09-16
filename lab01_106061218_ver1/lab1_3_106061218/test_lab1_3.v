`timescale 1ns / 1ps

module test_lab1_2;
wire [3:0] S;
wire CO;
reg [3:0] A,B;
reg CI;

lab1_2 U0(.s(S),.co(CO),.a(A),.b(B),.ci(CI));

initial
begin
A=4'b0000;B=4'b0000;CI=0;  
#100 A=4'b0000;B=4'b0001;
#100 A=4'b1000;B=4'b0100;
#100 A=4'b0011;B=4'b0101;
#100 A=4'b0010;B=4'b0000;CI=1;  
#100 A=4'b0000;B=4'b0111;
#100 A=4'b1001;B=4'b1001;
#100 A=4'b0100;B=4'b0011;
end   
endmodule
