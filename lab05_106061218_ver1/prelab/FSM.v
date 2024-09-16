`timescale 1ns / 1ps
`define STAT_STOP 1'b0
`define STAT_START 1'b1

module FSM(clk, rst, pause, freeze);    //按鈕功能的部分

/* Global Input */
input rst;
input clk;

/* Morre's Machine's Input */
input pause;    //按下按鈕與否
reg pause_tmp;  //剛剛有沒有按按鈕?
wire [1:0] in;

/* FSM狀態表 */
reg stat;   //現態
reg next_stat;  //次態
output reg freeze;  //輸出:是否要暫停?

/* "現在"與"上一個瞬間"是否按著按鈕? */
always @(posedge clk or negedge rst)
    if (~rst)
        pause_tmp <= 0;
    else 
        pause_tmp <= pause;
        
assign in = {pause, pause_tmp};

//FSM
always @(posedge clk or negedge rst)    //stat的FF
   if (~rst) 
        stat <= `STAT_START;    //預設只要打開開關,就是開始倒數
    else 
        stat <= next_stat;
        
          
always @*   //決定next_stat
case(stat) 
    `STAT_START:    //正在倒數時
        if (in == 01)   begin //只要剛剛有按,但現在沒按著按鈕
            next_stat = `STAT_STOP;    //就暫停
            freeze = 0;
        end    
        else begin   //包含"一直按著(11)","都沒碰(00)","剛按下去(10)"三種狀況
            next_stat = `STAT_START;   //先繼續倒數
            freeze = 1;
        end   
     `STAT_STOP:    //暫停時
         if (in == 01) begin//只要剛剛有按,但現在沒按著按鈕
            next_stat = `STAT_START; //就繼續倒數
            freeze = 1;
         end   
         else  begin //包含"一直按著(11)","都沒碰(00)","剛按下去(10)"三種狀況
            next_stat = `STAT_STOP;    //還是暫停
            freeze = 0;
         end   
    default: begin 
        next_stat = `STAT_START;    //預料之外的狀況不管它,繼續倒數
        freeze = 0;
    end
endcase

endmodule
