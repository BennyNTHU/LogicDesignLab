`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    input dip,
    output [3:0] ssd_ctl,
    output [7:0] BCD
    );
    
wire clk_1Hz;
wire [4:0] day_limit;
wire clk_month;
wire [3:0] day1, day2;
wire clk_year;
wire [3:0] month1, month2;
wire [3:0] year1, year2;

freq_div U0 (.clk(clk), .rst_n(rst), .signal(clk_1Hz));
decide U1 (.month1(month1), .month2(month2), .day_limit(day_limit));
day_counter U2 (.clk(clk_1Hz), .rst(rst), .limit(day_limit), .start(1),
                .carry(clk_month), .day1(day1), .day2(day2));  
month_counter U3 (.clk(clk_month), .rst(rst), .limit(12), .start(1), 
                  .carry(clk_year), .month1(month1), .month2(month2));
year_counter U4 (.clk(clk_year), .rst(rst), .limit(99), .start(0), .year1(year1), .year2(year2));
ssd U5 (.dip(dip), .clk(clk), .rst(rst), .day1(day1), .day2(day2), .month1(month1), 
        .month2(month2), .year1(year1), .year2(year2), .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule
