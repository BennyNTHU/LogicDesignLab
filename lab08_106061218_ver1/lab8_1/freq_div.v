`timescale 1ns / 1ps

module freq_div(clk, rst, signal, limit);

input clk;  //global clock
input rst;    
input [27:0] limit;
output reg signal;  //real output
reg [26:0] out; //Output of the  FF
reg [26:0] out_tmp; //Data of the FF

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
