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
    output reg [3:0] IRlights
    );
    
//    wire [2:0] finalAnswer = 0;
//    wire finalDone = 0;
//    reg [2:0] IRfreq = 0;
//    reg IRdone = 0;
    
    decisionCount uut3(
    clock,
    finalAnswer,
    finalDone,
    blinky,
    lightOut
    );
    
//    reg x = 0;
//    wire y = 0;
    
    //iririr
    always @ (posedge clock)
    begin
    
 //   IRfreq <= finalAnswer;
   // IRdone <= finalDone;
  //  blinky <= IRsignal;
    //IRlights <= lightOut;
    
    //x = y; //thing
    
    IRlights <= lightOut;
    
    end
    
endmodule
