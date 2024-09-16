`timescale 1ns / 1ps

module freq_div(clk, rst_n, signal);

input clk;  //global clock
input rst_n;    
output reg signal;  //real output
reg [26:0] out; //Output of the  FF
reg [26:0] out_tmp; //Data of the FF

always @(posedge clk or negedge rst_n) 
begin //第一個FF本體
    if (~rst_n)
    begin
        out <= 27'd0;
        signal <= 0;
    end
    else   
    begin    
        if (out == 4999999)
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
