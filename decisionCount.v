`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2020 08:41:01 PM
// Design Name: 
// Module Name: decisionCount
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


module decisionCount(
    input clk,
    output reg [2:0] finalAnswer,
    output reg finalDone,
    input blinky,
    output [4:0] lightOut
    );
    
    `include "paras.h"
    
    wire [2:0] decision;
    wire [19:0] clk_count;
    wire done;
    
     IRdetector uut1(
        blinky,
        clk_count,
        clk,
        done,
        decision
        );
        
    OutputDecision uut2(
        finalAnswer,
        finalDone,
        clk,
        lightOut
        );
    
    reg [3:0] R_Bcount = 0;
    reg [3:0] R_Gcount = 0;
    reg [3:0] B_Gcount = 0;
    reg [3:0] STOPcount = 0;
    
    always @ (posedge clk)
        begin
            if (done == 1 && decision == R_B)
                begin
                    R_Bcount <= R_Bcount + 1;
                    R_Gcount <= 0;
                    B_Gcount <= 0;
                    STOPcount <= 0;
                end
            else if (done == 1 && decision == R_G)
                begin
                    R_Bcount <= 0;
                    R_Gcount <= R_Gcount + 1;
                    B_Gcount <= 0;
                    STOPcount <= 0;
                end
            else if (done == 1 && decision == B_G)
                begin
                    R_Bcount <= 0;
                    R_Gcount <= 0;
                    B_Gcount <= B_Gcount + 1;
                    STOPcount <= 0;
                end
            else if (done == 1 && decision == STOP)
                begin
                    R_Bcount <= 0;
                    R_Gcount <= 0;
                    B_Gcount <= 0;
                    STOPcount <= STOPcount + 1;
                end
            else if (done == 1)
                begin 
                    R_Bcount <= 0;
                    R_Gcount <= 0;
                    B_Gcount <= 0;
                    STOPcount <= 0;
                end
        end
    
    always @ (posedge clk)
        begin
            if (R_Bcount == 15)
                begin
                    finalAnswer <= R_B;
                    finalDone <= 1;
                end
            else if (R_Gcount == 15)
                begin
                    finalAnswer <= R_G;
                    finalDone <= 1;
                end
            else if (B_Gcount == 15)
                begin
                    finalAnswer <= B_G;
                    finalDone <= 1;
                end
            else if (STOPcount == 15)
                begin
                    finalAnswer <= STOP;
                    finalDone <= 1;
                end
            else
                begin
                    finalDone <= 0;
                    finalAnswer <= NONE;
                end
      end 
    
endmodule
