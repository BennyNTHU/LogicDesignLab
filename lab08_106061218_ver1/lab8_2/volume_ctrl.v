`timescale 1ns / 1ps

module volumn_ctrl(
    input clk,
    input rst,
    input up_in,
    input down_in,
    output reg [15:0] volumn_down,
    output reg [15:0] volumn_up,
    output reg [3:0] out    //Volume
    );

wire up;
wire down;
reg [3:0] out_tmp;

debounced_circuit V0 (.clk(clk), .rst(~rst), .pb_in(up_in), .pb_debounced(up));
debounced_circuit V1 (.clk(clk), .rst(~rst), .pb_in(down_in), .pb_debounced(down));

always@(posedge clk or negedge rst)
    if(~rst)
        out <= 4'd0;
    else
        out <= out_tmp;
    
always@*
    if(up)
        out_tmp = out + 4'd1;
    else if(down)
        out_tmp = out - 4'd1;
    else
        out_tmp = out;
        
always@*
    case(out)
        4'd0: 
        begin 
            volumn_down = 16'hFC00;
            volumn_up = 16'h43FF;
        end
        4'd1: 
        begin 
            volumn_down = 16'hF800;
            volumn_up = 16'h47FF;
        end
        4'd2: 
        begin 
            volumn_down = 16'hF400;
            volumn_up = 16'h4BFF;
        end
        4'd3: 
        begin 
            volumn_down = 16'hB000;
            volumn_up = 16'h4FFF;
        end
        4'd4: 
        begin 
            volumn_down = 16'hAC00;
            volumn_up = 16'h53FF;
        end
        4'd5: 
        begin 
            volumn_down = 16'hA800;
            volumn_up = 16'h57FF;
        end
        4'd6: 
        begin 
            volumn_down = 16'hA400;
            volumn_up = 16'h5BFF;
        end
        4'd7: 
        begin 
            volumn_down = 16'hA000;
            volumn_up = 16'h5FFF;
        end
        4'd8: 
        begin 
            volumn_down = 16'h9C00;
            volumn_up = 16'h63FF;
        end
        4'd9: 
        begin 
            volumn_down = 16'h9800;
            volumn_up = 16'h67FF;
        end
        4'd10: 
        begin 
            volumn_down = 16'h9400;
            volumn_up = 16'h6BFF;
        end
        4'd11: 
        begin 
            volumn_down = 16'h9000;
            volumn_up = 16'h6FFF;
        end
        4'd12: 
        begin 
            volumn_down = 16'h8C00;
            volumn_up = 16'h73FF;
        end
        4'd13: 
        begin 
            volumn_down = 16'h8800;
            volumn_up = 16'h77FF;
        end    
        4'd14: 
        begin 
            volumn_down = 16'h8400;
            volumn_up = 16'h7BFF;
        end
        4'd15: 
        begin 
            volumn_down = 16'h8000;
            volumn_up = 16'h7FFF;
        end
        default:    //Same as 7
        begin
            volumn_down = 16'hA000;
            volumn_up = 16'h5FFF;    
        end
    endcase

endmodule
