`timescale 1ns / 1ps

module lab8_1_test;

reg CLK;
reg RST;
wire MCLK, LRCK, SCK;

top U0 (.clk(CLK), .rst(RST), .audio_mclk(MCLK), .audio_lrck(LRCK), .audio_sck(SCK));

always #5 CLK = ~CLK;

initial 
begin
    CLK = 1'b0; RST = 1'b0;
    #5 RST = 1'b0;
    #5 RST = 1'b1;
end

endmodule
