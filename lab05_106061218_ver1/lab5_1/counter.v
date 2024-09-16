`timescale 1ns / 1ps

module counter(
    input clk,
    input rst,
    input en,
    output [3:0] sec1, //十位數
    output [3:0] sec2   //個位數
    );

reg [4:0] sec, sec_tmp;
    
always@ (posedge clk or posedge rst)
    if (rst)
        sec <= 30;
    else
        sec <= sec_tmp;
        
always @*
    if (en == 1)
    begin
        if (sec != 0)
            sec_tmp = sec - 1;
        else
            sec_tmp = 0;
    end
    else
        sec_tmp = sec_tmp;

assign sec1 = sec / 10;
assign sec2 = sec % 10;

endmodule
