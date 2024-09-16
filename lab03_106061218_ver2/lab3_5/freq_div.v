`timescale 1ns / 1ps

module freq_div(clk, rst, signal);

input clk;  //global clock
input rst;    
output reg signal;  //real output
reg [26:0] out; //Output of the  FF
reg [26:0] out_tmp; //Data of the FF

always @(posedge clk or negedge rst) 
begin //第一個FF本體
    if (~rst)
    begin
        out <= 27'd0;
        signal <= 0;
    end
    else   
    begin    
        if (out == 49999999)
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
