`timescale 1ns / 1ps

module note_ctrl(
    input clk,
    input rst_n,
    output reg [21:0]note_out
    );

reg [3:0] cnt, cnt_tmp;
wire clk_1Hz;

freq_div V0 (.clk(clk), .rst(rst_n), .signal(clk_1Hz), .limit(49999999));

always @(posedge clk_1Hz or negedge rst_n)
    if (~rst_n)
        cnt <= 4'b0000;
    else 
        cnt <= cnt_tmp;
        
always @*
    cnt_tmp = cnt + 1;

always @*
case (cnt)
    4'd0: note_out = 22'd227273;    //A
    4'd1: note_out = 22'd204082;    //B
    4'd2: note_out = 22'd191571;    //C
    4'd3: note_out = 22'd170648;    //D
    4'd4: note_out = 22'd151515;    //E
    4'd5: note_out = 22'd143266;    //F
    4'd6: note_out = 22'd127551;    //G
    4'd7: note_out = 22'd113636;    //A
    4'd8: note_out = 22'd101215;    //B
    4'd9: note_out = 22'd95420;     //C
    4'd10: note_out = 22'd85034;    //D
    4'd11: note_out = 22'd75758;    //E
    4'd12: note_out = 22'd71633;    //F
    4'd13: note_out = 22'd63776;    //G
    4'd14: note_out = 22'd56818;    //A
    4'd15: note_out = 22'd50607;    //B
    default: note_out = 22'd000000;
endcase

endmodule
