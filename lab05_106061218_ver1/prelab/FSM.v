`timescale 1ns / 1ps
`define STAT_STOP 1'b0
`define STAT_START 1'b1

module FSM(clk, rst, pause, freeze);    //���s�\�઺����

/* Global Input */
input rst;
input clk;

/* Morre's Machine's Input */
input pause;    //���U���s�P�_
reg pause_tmp;  //��観�S�������s?
wire [1:0] in;

/* FSM���A�� */
reg stat;   //�{�A
reg next_stat;  //���A
output reg freeze;  //��X:�O�_�n�Ȱ�?

/* "�{�b"�P"�W�@������"�O�_���۫��s? */
always @(posedge clk or negedge rst)
    if (~rst)
        pause_tmp <= 0;
    else 
        pause_tmp <= pause;
        
assign in = {pause, pause_tmp};

//FSM
always @(posedge clk or negedge rst)    //stat��FF
   if (~rst) 
        stat <= `STAT_START;    //�w�]�u�n���}�}��,�N�O�}�l�˼�
    else 
        stat <= next_stat;
        
          
always @*   //�M�wnext_stat
case(stat) 
    `STAT_START:    //���b�˼Ʈ�
        if (in == 01)   begin //�u�n��観��,���{�b�S���۫��s
            next_stat = `STAT_STOP;    //�N�Ȱ�
            freeze = 0;
        end    
        else begin   //�]�t"�@������(11)","���S�I(00)","����U�h(10)"�T�ت��p
            next_stat = `STAT_START;   //���~��˼�
            freeze = 1;
        end   
     `STAT_STOP:    //�Ȱ���
         if (in == 01) begin//�u�n��観��,���{�b�S���۫��s
            next_stat = `STAT_START; //�N�~��˼�
            freeze = 1;
         end   
         else  begin //�]�t"�@������(11)","���S�I(00)","����U�h(10)"�T�ت��p
            next_stat = `STAT_STOP;    //�٬O�Ȱ�
            freeze = 0;
         end   
    default: begin 
        next_stat = `STAT_START;    //�w�Ƥ��~�����p���ޥ�,�~��˼�
        freeze = 0;
    end
endcase

endmodule
