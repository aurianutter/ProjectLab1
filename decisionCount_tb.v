`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2020 08:59:09 PM
// Design Name: 
// Module Name: decisionCount_tb
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


module decisionCount_tb(

    );
    
    `include "paras.h"
    
    reg clk = 0;
    wire [2:0] finalAnswer;
    wire finalDone;
    reg blinky = 0;
    integer i = 0;
    
    always #5 clk = ~clk;
    //always #2500000 blinky = ~blinky; // 200 Hz
    initial begin
        for (i = 0; i < 200; i = i + 1)
            #2500000 blinky = ~blinky;
        for (i = 0; i < 1000; i = i + 1)
            #500000 blinky = ~blinky;
    end
    
    decisionCount uut (
        clk,
        finalAnswer,
        finalDone,
        blinky
        );
    
endmodule
