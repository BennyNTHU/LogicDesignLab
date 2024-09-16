`timescale 1ns / 1ps

module debounced_circuit(
  clk, // clock control
  rst, // reset
  pb_in, //push button input
  pb_debounced // debounced push button output
);

// declare the I/Os
input clk; // clock control
input rst; // reset
input pb_in; //push button input
output pb_debounced; // debounced push button output

// declare the internal nodes
reg [3:0] debounce_window; // shift register flip flop
reg pb_debounced_next; // debounce result
reg pb_debounced; // debounced push button output

// Shift register
always @(posedge clk or posedge rst)
  if (rst)
    debounce_window <= 4'd0;
  else
    debounce_window <= {debounce_window[2:0],pb_in}; 

// debounce circuit
always @*
  if (debounce_window == 4'b1111) 
    pb_debounced_next = 1'b1;
  else
    pb_debounced_next = 1'b0;

always @(posedge clk or posedge rst)
  if (rst)
    pb_debounced <= 1'b0;
  else
    pb_debounced <= pb_debounced_next;
	 
endmodule
