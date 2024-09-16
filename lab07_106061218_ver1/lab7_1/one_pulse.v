`timescale 1ns / 1ps

module one_pulse(
    out_pulse,  //output one pulse
    clk,  //clock input
    in_trig  //input trigger
    );
    
    output reg out_pulse;  //output one pulse
    input clk;  //clock input
    input in_trig;  //input trigger
    
    reg in_trig_delay;
    wire one_pulse_next;
    
    //buffer input
    always@(posedge clk)
        in_trig_delay <= in_trig;
                
    //pulse generation
    assign one_pulse_next = in_trig & (~in_trig_delay);
    
    always@(posedge clk)
        out_pulse <= one_pulse_next;
    
endmodule
