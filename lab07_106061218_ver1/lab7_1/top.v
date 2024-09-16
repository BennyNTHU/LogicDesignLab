`timescale 1ns / 1ps

module top(
    input clk,
    input button1,  // for lab and reset
    input button2,  // for start stop
    output [3:0] ssd_ctl,
    output [7:0] BCD
    );
    
wire clk_100Hz;
wire clk_10Hz;

wire pb_debounced;
wire pb_one_pulse, pb_one_pulse2;
wire pb_debounced2;

wire count_enable;
wire current_state;

wire [3:0] sec1;
wire [3:0] sec2;
wire [3:0] min1;
wire [3:0] min2;
wire clk_min;

wire rst;
wire lap;

freq_div U0(.clk(clk), .rst(1), .limit(4999999), .signal(clk_1Hz));

freq_div U1(.clk(clk), .rst(1), .limit(499999), .signal(clk_100Hz));

debounce U2(.clk(clk_100Hz), .pb_in(button1), .pb_debounced(pb_debounced));

one_pulse U3(.clk(clk), .out_pulse(pb_one_pulse), .in_trig(pb_debounced));

FSM U5 (.clk(clk), .rst(rst), .in(pb_one_pulse), .count_enable(count_enable), .current_state(current_state));

debounce U6(.clk(clk_100Hz), .pb_in(button2), .pb_debounced(pb_debounced2));

one_pulse U7(.clk(clk), .out_pulse(pb_one_pulse2), .in_trig(pb_debounced2));

decide U8 (.clk(clk), .deb(pb_debounced2), .in(pb_one_pulse2), .rst(rst), .state(lap));

sec_counter U9 (.clk(clk_1Hz), .rst(rst), .en(count_enable),
                .limit(59), .start(0), 
                .carry(clk_min), .sec1(sec1), .sec2(sec2));
                
min_counter U10 (.clk(clk_min), .rst(rst), .en(count_enable),
                .limit(59), .start(0), .min1(min1), .min2(min2));
                 
ssd U11 (.clk(clk), .rst(rst), .lap(lap), .sec1(sec1), .sec2(sec2), .min1(min1), .min2(min2), 
         .ssd_ctl(ssd_ctl), .BCD(BCD));

endmodule
