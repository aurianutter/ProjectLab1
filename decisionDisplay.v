`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2020 01:45:12 PM
// Design Name: 
// Module Name: decisionDisplay
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


module decisionDisplay(
    input blinky,
    input clk,
    output [2:0] LEDout
    );
endmodule

    `include "paras.h"
    
    wire [2:0] finalAnswer;
    wire finalDone;
    
    
    decisionCount uut(
    clk,
    finalAnswer,
    finalDone,
    blinky
    );