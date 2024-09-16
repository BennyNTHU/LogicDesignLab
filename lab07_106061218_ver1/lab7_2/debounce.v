`timescale 1ns / 1ps

module debounce(
    clk,  //clock control
    pb_in,  //push botton input
    pb_debounced  //debounced push botton output
    );
    
    output reg pb_debounced;  //debounced push botton output
    input clk;  //clock control
    input pb_in;  //push botton input
    
    reg [3:0]debounce_window;  //shift register flip flop
    wire pb_debounced_next;  //debounce result
    
    //shift register
    always@(posedge clk)
        debounce_window <= {debounce_window[2:0],pb_in};
            
    //debounce circuit
    assign pb_debounced_next = debounce_window[3] & debounce_window[2] & debounce_window[1] & debounce_window[0];
    
    always@(posedge clk)
        pb_debounced <= pb_debounced_next;
     
endmodule
