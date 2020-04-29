`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2020 07:23:46 PM
// Design Name: 
// Module Name: Percentage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Percentage(
    input [19:0] numerator,
    input [19:0] denominator,
    output reg [6:0] answer,
    input go,
    output reg done,
    input clk,
    input reset
    );
    
    reg [2:0] state = 0;
    reg [26:0] top = 0;
    reg [26:0] bottom = 0;
    
    initial begin
        done = 0;
    end
    
    always @ (posedge clk)
        begin
            if (reset)
                begin
                    state <= 0;
                    answer <= 0;
                    done <= 0;
                end
            else
                begin
                    case (state)
                        0: if (go) 
                            begin
                                top = numerator * 100;
                                bottom <= 0;
                                answer <= 0;
                                state <= 1;
                                done <= 0;
                                if (denominator == 0)
                                    begin
                                        state <= 3;
                                        answer <= 0;
                                        done <= 1;
                                    end
                            end
                        1: 
                            begin
                                bottom <= bottom + denominator;
                                answer <= answer + 1;
                                state <= 2;
                            end
                        2: 
                            if (answer == 127)
                                begin
                                    done <= 1;
                                    state <= 3;
                                end
                            else if (top > bottom) // go again
                            begin
                                state <= 1;
                            end
                            
                            else // done
                            begin
                                done <= 1;
                                state <= 3;
                            end
                        3:
                            if (~go)
                                begin
                                    state <= 0;
                                    done <= 0;
                                end
                    endcase
                end
    end
endmodule
