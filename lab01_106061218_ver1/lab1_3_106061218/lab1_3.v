module lab1_2(a,b,ci,s,co);

input [3:0] a;
input [3:0] b;
input ci;
output reg [3:0] s;
output reg co;
reg [4:0] mS;
    
always @(a or b or ci)
begin 
    mS = a + b + ci;
    if ( mS > 9 ) begin
        co = 1;
        mS = mS - 10;
    end
    else begin
        co=0;
    end
      
s = {mS[3:0]};
end

endmodule