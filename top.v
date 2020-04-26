`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2020 07:47:55 PM
// Design Name: 
// Module Name: top
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


module top(
    input blinky,
    input clock,
    output [3:0] IRlights
    );
    
    wire [2:0] finalAnswer;
    wire finalDone;
    wire [3:0] lightOut;

    
    decisionCount uut3(
    clock,
    finalAnswer,
    finalDone,
    blinky,
    lightOut
    );
    
    assign IRlights = lightOut;
    
    
endmodule
