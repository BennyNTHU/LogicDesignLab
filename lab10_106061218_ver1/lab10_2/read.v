`timescale 1ns / 1ps

module read(
    input clk,
    input rst_n,
    input [31:0]in_reg,
    output so,
    output audio_mclk,
    output audio_lrck,
    output audio_sck
    );

reg [31:0]q;
reg [31:0]r;
wire b_clk;

load V1 (.s_clk(audio_sck), .rst_n(rst_n), .load(load));
freq_div W1 (.clk(clk), .rst(rst_n), .signal(audio_lrck), .limit(27'd255)); //clk_LR
freq_div W2 (.clk(clk), .rst(rst_n), .signal(audio_mclk), .limit(27'd1)); //clk25MHz
freq_div W3 (.clk(clk), .rst(rst_n), .signal(audio_sck), .limit(27'd7)); //clk_sampling

always @(negedge load)
     q<=in_reg;

always @(negedge audio_sck or negedge rst_n) 
    if (~rst_n)
        r <= 32'd0;
    else if (load)
        r <= q;
    else
        r <= {r, 1'b0};

assign so = r[31];

endmodule
