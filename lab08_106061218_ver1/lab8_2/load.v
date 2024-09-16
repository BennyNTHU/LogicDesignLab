`timescale 1ns / 1ps

module load(
    input s_clk,
    input rst,
    output load
    );
    
reg [31:0] q;
wire [31:0] in_reg;

assign load = q[0];
assign in_reg = 32'd2147483648;  
always @(negedge s_clk or negedge rst)
    if(~rst)    // left channel
    begin
        q[31]<=in_reg[0];
        q[30]<=in_reg[1];
        q[29]<=in_reg[2];
        q[28]<=in_reg[3];
        q[27]<=in_reg[4];
        q[26]<=in_reg[5];
        q[25]<=in_reg[6];
        q[24]<=in_reg[7];
        q[23]<=in_reg[8];
        q[22]<=in_reg[9];
        q[21]<=in_reg[10];
        q[20]<=in_reg[11];
        q[19]<=in_reg[12];
        q[18]<=in_reg[13];
        q[17]<=in_reg[14];
        q[16]<=in_reg[15];
        q[15]<=in_reg[16];
        // right channel    
        q[14]<=in_reg[17];
        q[13]<=in_reg[18];
        q[12]<=in_reg[19];
        q[11]<=in_reg[20];
        q[10]<=in_reg[21];
        q[9]<=in_reg[22];
        q[8]<=in_reg[23];
        q[7]<=in_reg[24];
        q[6]<=in_reg[25];
        q[5]<=in_reg[26];
        q[4]<=in_reg[27];
        q[3]<=in_reg[28];
        q[2]<=in_reg[29];
        q[1]<=in_reg[30];
        q[0]<=in_reg[31];
    end
    else
    begin
        q[31]<=q[0];
        q[30]<=q[31];
        q[29]<=q[30];
        q[28]<=q[29];
        q[27]<=q[28];
        q[26]<=q[27];
        q[25]<=q[26];
        q[24]<=q[25];
        q[23]<=q[24];
        q[22]<=q[23];
        q[21]<=q[22];
        q[20]<=q[21];
        q[19]<=q[20];
        q[18]<=q[19];
        q[17]<=q[18]; 
        q[16]<=q[17];
        q[15]<=q[16];
        q[14]<=q[15];
        q[13]<=q[14];
        q[12]<=q[13];
        q[11]<=q[12];
        q[10]<=q[11];
        q[9]<=q[10];
        q[8]<=q[9];
        q[7]<=q[8];
        q[6]<=q[7];
        q[5]<=q[6];
        q[4]<=q[5];
        q[3]<=q[4];
        q[2]<=q[3];
        q[1]<=q[2];
        q[0]<=q[1];
    end

endmodule
