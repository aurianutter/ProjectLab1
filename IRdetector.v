`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2020 11:43:22 AM
// Design Name: 
// Module Name: IRdetector
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


module IRdetector(
    input blinky,
    output reg [19:0] clk_count,
    input clk,
    output reg done,
    output reg [2:0] decision

    );
    
    `include "paras.h"
    
    reg SyncBlinky;
    reg OldBlinky;
    wire StartCount;
    reg [19:0] count = 0;
    
    always @ (posedge clk)
        begin 
            SyncBlinky <= blinky;
            OldBlinky <= SyncBlinky;
        end
        
    assign StartCount = (~OldBlinky & SyncBlinky);
    
    initial begin
    clk_count = 0;
    done = 0;
    decision = 0;
    end
    
    always @ (posedge clk)
        begin
            if (StartCount == 1)
                begin
                    clk_count <= count;
                    count <= 0;
                    done <= 1;
                end
            if (StartCount == 0)
                begin
                    done <= 0;
                    count <= count + 1;
                end    
        end
        
    always @ (posedge clk)
        begin
            if (done == 1)
                if (clk_count > 490000 & clk_count < 510000) // 200 Hz 500000
                    begin
                        decision <= R_B;
                    end
                else if (clk_count > 90000 & clk_count < 110000) // 1000 Hz 100000
                    begin
                        decision <= R_G;
                    end
                else if (clk_count > 19000 & clk_count < 21000) // 5000 Hz 20000
                    begin
                        decision <= B_G;
                    end
//                else if (clk_count > 3000 & clk_count < 3500) // 30000 Hz 3333
//                    begin
//                        decision <= STOP;
//                    end
                else if (clk_count > 10000 & clk_count < 16000) // 7000 Hz 14000
                    begin
                        decision <= STOP;
                    end
                else
                    begin
                        decision <= NONE;
                    end
        end
 
endmodule
