module prelab3_test();

wire [3:0] OUT;
reg CLK;
reg RST;

prelab03 U0(.out(OUT), .clk(CLK), .rst_n(RST));

always #5 CLK = ~CLK;

initial
begin
    CLK = 0; RST = 0;
    #10 RST = 1;
end

endmodule
