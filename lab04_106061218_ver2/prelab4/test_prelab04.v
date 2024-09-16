`timescale 1ns / 1ps

module test_prelab04;

wire [7:0] F;
reg RST, CLK;

prelab04 U0(.rst(RST), .clk(CLK), .f(F));

always #5 
begin
    CLK = ~CLK;
end

initial
begin
    CLK = 0; RST = 1;
    #10 RST = 0;
end
endmodule
