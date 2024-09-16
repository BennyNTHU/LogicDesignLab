`timescale 1ns / 1ps

module long_press(
    input in,
    input clk,
    output reg out,
    output reg rst
    );

reg [26:0]count;
reg [26:0]count_tmp0;
reg [26:0]count_tmp1;
    
always@*
    if(in == 1'b1)
        count_tmp0 = count + 1'b1;
    else
        count_tmp0 = 27'b0;
            
always@*
    if(count_tmp0 == 27'd100000000-1)
    begin
        count_tmp1 = 27'b0;
        rst = 1'b1;
    end
    else
    begin
        count_tmp1 = count_tmp0;
        rst = 1'b0;
    end
    
always@(posedge clk)
    count <= count_tmp1;
        
always@*
    out = in & (~rst);
    
endmodule
