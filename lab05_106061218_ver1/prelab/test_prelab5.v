`timescale 1ns / 1ps

module test_prelab05();

reg clk;
reg rst;
reg pause;
wire [4:0]bit30;
wire freeze;

top U3 (.rst(rst), .clk(clk), .pause(pause), .freeze(freeze), .bit30(bit30));

always #5 
begin
    clk = ~clk; // 將 clock 反相 (0 變 1 、1 變 0)
end

initial
begin
   clk = 0; pause = 0; rst = 0;
   #10 rst = 1;
   #23 pause = 1;
   #25 pause = 0;
   #30 pause = 1;
   #20 pause = 0;
   #100 pause = 1;
   #20 pause = 0;
end

endmodule
