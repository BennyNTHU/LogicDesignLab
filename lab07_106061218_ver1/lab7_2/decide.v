`timescale 1ns / 1ps

module decide(
    input clk,
    input deb,
    input in,
    output reg rst,
    output reg state
    );

reg next_state;
reg [26:0] cnt, cnt_tmp;

always@(posedge clk or posedge rst)
    if (rst)
        state <= 1'b0;
    else
        state <= next_state;

always@*
    case(state)
        1'b0: 
        begin
            if (in)
                next_state = 1'b1;
            else
                next_state = 1'b0;
        end
        1'b1: 
        begin
            if (in)
                next_state = 1'b0;
            else
                next_state = 1'b1;
        end
    endcase
        
always @(posedge clk)
    cnt <= cnt_tmp;
    
always @(cnt)
begin
    if (deb == 1)
    begin
        if (cnt <= 49999999)
        begin
            cnt_tmp = cnt + 1;
            rst = 0;
        end
        else
        begin
            cnt_tmp = cnt + 1;
            rst = 1;
        end
    end
    else
    begin  
        cnt_tmp = 0;
        rst = 0;
    end
end
    
endmodule
