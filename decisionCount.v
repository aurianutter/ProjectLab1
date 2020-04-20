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
    
    always @ (posedge clk) // increment seen frequency and zero all others
        begin
            if (done == 1 && decision == 1) // increment for 200 Hz
                begin
                    R_Bcount <= R_Bcount + 1;
                    R_Gcount <= 0;
                    B_Gcount <= 0;
                    STOPcount <= 0;
                end
            else if (done == 1 && decision == 2) // increment for 1000 Hz
                begin
                    R_Bcount <= 0;
                    R_Gcount <= R_Gcount + 1;
                    B_Gcount <= 0;
                    STOPcount <= 0;
                end
            else if (done == 1 && decision == 3) // increment for 5000 Hz
                begin
                    R_Bcount <= 0;
                    R_Gcount <= 0;
                    B_Gcount <= B_Gcount + 1;
                    STOPcount <= 0;
                end
            else if (done == 1 && decision == 4) // increment for 7000 Hz
                begin
                    R_Bcount <= 0;
                    R_Gcount <= 0;
                    B_Gcount <= 0;
                    STOPcount <= STOPcount + 1;
                end
            else if (done == 1) // zero all counts if no frequency
                begin 
                    R_Bcount <= 0;
                    R_Gcount <= 0;
                    B_Gcount <= 0;
                    STOPcount <= 0;
                end
        end
    
    always @ (posedge clk) // set finalAnswer if seen long enough
        begin
            if (R_Bcount == 15)
                begin
                    finalAnswer <= 1;
                    finalDone <= 1;
                end
            else if (R_Gcount == 15)
                begin
                    finalAnswer <= 2;
                    finalDone <= 1;
                end
            else if (B_Gcount == 15)
                begin
                    finalAnswer <= 3;
                    finalDone <= 1;
                end
            else if (STOPcount == 15)
                begin
                    finalAnswer <= 4;
                    finalDone <= 1;
                end
            else
                begin
                    finalDone <= 0;
                    finalAnswer <= 0;
                end
      end 
    
endmodule
