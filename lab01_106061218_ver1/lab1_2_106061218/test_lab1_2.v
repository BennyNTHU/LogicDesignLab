`timescale 1ns / 1ps
module test_lab1_3;

wire [7:0] D;
reg EN;
reg [2:0] IN;

lab1_3 U0(.d(D), .en(EN), .in(IN));

initial
begin
EN = 0; IN[2] = 1; IN[1] = 1; IN[0] = 1;
#10 EN = 1; IN[2] = 0; IN[1] = 0; IN[0] = 0;
#10 EN = 1; IN[2] = 0; IN[1] = 0; IN[0] = 1;
#10 EN = 1; IN[2] = 0; IN[1] = 1; IN[0] = 0;
#10 EN = 1; IN[2] = 0; IN[1] = 1; IN[0] = 1;
#10 EN = 1; IN[2] = 1; IN[1] = 0; IN[0] = 0;
#10 EN = 1; IN[2] = 1; IN[1] = 0; IN[0] = 1;
#10 EN = 1; IN[2] = 1; IN[1] = 1; IN[0] = 0;
#10 EN = 1; IN[2] = 1; IN[1] = 1; IN[0] = 1;
end
endmodule
