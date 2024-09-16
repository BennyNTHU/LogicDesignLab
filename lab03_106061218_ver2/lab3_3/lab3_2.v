`timescale 1ns / 1ps

module freq_div(clk, rst, clk_1Hz);

input clk;  //global clock
input rst;    //Switch of two FFs
output reg clk_1Hz;  //real output
reg [26:0] out; //Output of the first FF

always @(posedge clk or negedge rst) 
    begin //第一個FF本體
        if (~rst)
            begin
                out <= 27'd0;
                clk_1Hz <= 0;
            end
        else   
            begin    
                if (out == 49999999)
                    begin    
                        clk_1Hz <= ~clk_1Hz;
                        out <= 27'd0;
                    end
                else
                    begin
                        out <= out + 1;
                        clk_1Hz <= clk_1Hz; 
                    end
            end
      end    
endmodule
