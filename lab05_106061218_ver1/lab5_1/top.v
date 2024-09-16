`timescale 1ns / 1ps
`define LIGHT_LED 16'b1111111111111111
`define NO_LED 16'b0

module top(
    input clk,
    input rst,
    input pb_in,
    output [7:0] BCD,
    output [3:0] ssd_ctl,
    output reg[15:0] LED
    );
    
wire clk_1Hz;
wire clk_100Hz;
wire pb_debounced;
wire pb_one_pulse;

wire count_enable;
wire current_state;

wire [3:0] sec1;
wire [3:0] sec2;
    
freq_div U0(.clk(clk), .rst(1), .limit(49999999), .signal(clk_1Hz));

freq_div U1(.clk(clk), .rst(1), .limit(499999), .signal(clk_100Hz));
        
debounce U2(.clk(clk_100Hz), .pb_in(pb_in), .pb_debounced(pb_debounced));
        
one_pulse U3(.clk(clk), .out_pulse(pb_one_pulse), .in_trig(pb_debounced));
        
FSM U4(.clk(clk), .rst(rst), .in(pb_one_pulse),
       .count_enable(count_enable), .current_state(current_state));
       
counter U5(.clk(clk_1Hz), .rst(rst), .en(count_enable), .sec1(sec1), .sec2(sec2));
        
ssd U6(.clk(clk), .rst(rst), .sec1(sec1), .sec2(sec2), .ssd_ctl(ssd_ctl), .BCD(BCD));
        
always@*    
    if((sec1 == 0) && (sec2 == 0))
        LED = `LIGHT_LED;
    else
        LED = `NO_LED;
    
endmodule
