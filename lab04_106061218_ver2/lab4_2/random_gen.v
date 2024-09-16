`timescale 1ns / 1ps

module random_gen(
    input clk,
    input rst,
    output reg [7:0] random
    );

reg [7:0] count;
reg [7:0] count_temp;

always@ (count)
    count_temp = count + 1;
    
always@ (posedge clk or negedge rst)
    if (~rst)
        random <= count_temp;
    else
        count <= count_temp;

endmodule
