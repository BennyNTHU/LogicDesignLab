`timescale 1ns / 1ps

module set(
    input dip,
    input rst,
    input min_set,
    input hour_set,
    output [3:0] limit_min1, limit_min2, limit_hour1, limit_hour2,
    output reg [5:0] limit_min, limit_hour
    );
    
always @*
        if (dip)
        begin
            if (hour_set)
            begin
                if (limit_hour < 23)
                    limit_hour = limit_hour + 1;
                else
                    limit_hour = 0;
            end
            else if (min_set)
                if (limit_min < 59)
                    limit_min = limit_min + 1;
                else
                    limit_min = 0;
            else
            begin
                limit_hour = limit_hour;
                limit_min = limit_min;
            end          
        end
        else
        begin
            limit_hour = limit_hour;
            limit_min = limit_min;
        end
    


assign limit_min1 = limit_min / 10;
assign limit_min2 = limit_min % 10;
assign limit_hour1 = limit_hour / 10;
assign limit_hour2 = limit_hour % 10;

endmodule
