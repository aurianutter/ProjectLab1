`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2020 07:25:15 PM
// Design Name: 
// Module Name: OutputDecision_tb
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


module OutputDecision_tb(
    );
    
    `include "paras.h"
    
    reg clk = 0;
    reg [2:0] finalAnswer = 0;
    reg finalDone = 0;
    wire [4:0] lightOut;
    
    always #5 clk = ~clk;
    initial begin 
       
       #100 
       finalDone = 1;
       finalAnswer = 0;
       #10
       finalDone = 0;
       #100 
       finalDone = 1;
       finalAnswer = 1;
       #10
       finalDone = 0; 
       #100 
       finalDone = 1;
       finalAnswer = 2;
       #10 
       finalDone = 0;
       #100 
       finalDone = 1;
       finalAnswer = 3;
       #10
       finalDone = 0;
       #100
       finalDone = 1;
       finalAnswer = 4;
    end
        
    OutputDecision uut(
    finalAnswer,
    finalDone,
    clk,
    lightOut
    );
    
endmodule
