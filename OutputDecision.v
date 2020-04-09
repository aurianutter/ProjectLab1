`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2020 06:23:44 PM
// Design Name: 
// Module Name: OutputDecision
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


module OutputDecision(
    input [2:0] finalAnswer,
    input finalDone,
    input clk,
    output reg [4:0] lightOut
    );

    `include "paras.h"
    
    initial begin
        lightOut = 0;
    end
    
    always @ (posedge clk)
        begin
            if (finalDone == 1)
                begin
                    if (finalAnswer == NONE)
                        begin
                            lightOut <= 1;
                        end
                    else if (finalAnswer == R_B)
                        begin
                            lightOut <= 2;
                        end
                    else if (finalAnswer == R_G)
                        begin
                            lightOut <= 4;
                        end
                    else if (finalAnswer == B_G)
                        begin
                            lightOut <= 8;
                        end
                    else if (finalAnswer == STOP)
                        begin
                            lightOut <= 16;
                        end
                    else
                        begin
                            lightOut <= 0;
                        end
                end
        end
            
            
            
            
endmodule