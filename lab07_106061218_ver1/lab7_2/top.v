`timescale 1ns / 1ps

module top(
    input clk,
    input dip,
    input button1,  // for lab and reset
    input button2,  // for start stop
    input button3,
    input button4,
    output [3:0] ssd_ctl,
    output [7:0] BCD
    );
    
wire clk_100Hz;
wire clk_10Hz;

wire pb_debounced1, pb_debounced2, pb_debounced3, pb_debounced4;
wire pb_one_pulse1, pb_one_pulse2, pb_one_pulse3, pb_one_pulse4;

wire count_enable;
wire current_state;

wire [5:0] limit_min, limit_hour, hour;
wire [3:0] limit_min1, limit_min2, limit_hour1, limit_hour2;
wire [3:0] min1, min2, hour1, hour2;
wire clk_min;

wire rst;
wire lap;

freq_div U0(.clk(clk), .rst(1), .limit(4999999), .signal(clk_1Hz));
freq_div U1(.clk(clk), .rst(1), .limit(499999), .signal(clk_100Hz));

debounce U2(.clk(clk_100Hz), .pb_in(button1), .pb_debounced(pb_debounced1));
debounce U3(.clk(clk_100Hz), .pb_in(button2), .pb_debounced(pb_debounced2));
debounce U4(.clk(clk_100Hz), .pb_in(button3), .pb_debounced(pb_debounced3));
debounce U5(.clk(clk_100Hz), .pb_in(button4), .pb_debounced(pb_debounced4));
one_pulse U6(.clk(clk), .rst_n(rst), .out_pulse(pb_one_pulse1), .in_trig(pb_debounced1));
one_pulse U7(.clk(clk), .rst_n(rst), .out_pulse(pb_one_pulse2), .in_trig(pb_debounced2));
one_pulse U8(.clk(clk), .rst_n(rst), .out_pulse(pb_one_pulse3), .in_trig(pb_debounced3));
one_pulse U9(.clk(clk), .rst_n(rst), .out_pulse(pb_one_pulse4), .in_trig(pb_debounced4));

FSM U10 (.clk(clk), .rst(rst), .in(pb_one_pulse1), .count_enable(count_enable), .current_state(current_state));

decide U11 (.clk(clk), .deb(pb_debounced2), .in(pb_one_pulse2), .rst(rst), .state(lap));

set U12 (.dip(dip), .rst(rst), .min_set(pb_one_pulse3), .hour_set(pb_one_pulse4),
         .limit_min1(limit_min1), .limit_min2(limit_min2), 
         .limit_hour1(limit_hour1), .limit_hour2(limit_hour2),
         .limit_min(limit_min), .limit_hour(limit_hour));

sec_counter U13 (.clk(clk_1Hz), .rst(rst), .en(count_enable),
                .limit(limit_min), .start(0), .min(hour),
                .carry(clk_min), .sec1(min1), .sec2(min2));
                
min_counter U14 (.clk(clk_min), .rst(rst), .en(count_enable),
                .limit(limit_hour), .start(0), .min1(hour1), .min2(hour2), .min(hour));
                 
ssd U15 (.clk(clk), .rst(rst), .lap(lap), .dip(dip),
         .limit_hour1(limit_hour1), .limit_hour2(limit_hour2),
         .limit_min1(limit_min1), .limit_min2(limit_min2),
         .sec1(min1), .sec2(min2), .min1(hour1), .min2(hour2), 
         .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule
