`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2020 12:07:16 PM
// Design Name: 
// Module Name: IRdetector_tb
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


module IRdetector_tb(

    );
    
    `include "paras.h"
    
    reg blinky = 0;
    reg clk = 0;
    wire [19:0] clk_count;
    wire done;
    wire [2:0] decision;
    
    always #5 clk = ~clk;
    //always #2500000 blinky = ~blinky; // 200 Hz
    //always #500000 blinky = ~blinky; // 1000 Hz
    //always #100000 blinky = ~blinky; // 5000 Hz
    always #72000 blinky = ~blinky; // 7000 Hz
    IRdetector uut(
        blinky,
        clk_count,
        clk,
        done,
        decision

        );
    
endmodule
