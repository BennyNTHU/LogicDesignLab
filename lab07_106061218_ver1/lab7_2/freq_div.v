`timescale 1ns / 1ps

module freq_div(clk, rst, signal, limit);

input clk;  
input rst;
input [26:0] limit;    
output reg signal; 
reg [26:0] out;
reg [26:0] out_tmp;

always @(posedge clk or negedge rst) 
begin 
    if (~rst)
    begin
        out <= 27'd0;
        signal <= 0;
    end
    else   
    begin    
        if (out == limit)
        begin    
            signal <= ~signal;
            out <= 27'd0;
        end
        else
        begin
            out <= out + 1;
            signal <= signal; 
        end
    end
end

endmodule
