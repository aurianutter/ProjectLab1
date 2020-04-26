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
    input clock,
    output reg done,
    output reg [2:0] decision

    );
    
    reg SyncBlinky;
    reg OldBlinky;
    wire StartCount;
    reg [19:0] count = 0;
    
    always @ (posedge clock) //synchronize blinky
        begin 
            SyncBlinky <= blinky;
            OldBlinky <= SyncBlinky;
        end
        
    assign StartCount = (~OldBlinky & SyncBlinky); //rising edge
    
    initial begin
    clk_count = 0;
    done = 0;
    decision = 0;
    end
    
    always @ (posedge clock)
        begin
            if (StartCount == 1) //on rising edge, clk_count valid
                begin
                    clk_count <= count;
                    count <= 0;
                    done <= 1;
                end
            if (StartCount == 0)// on not rising edge, increment
                begin
                    done <= 0;
                    count <= count + 1;
                end    
        end
        
    always @ (posedge clock) //establish ranges for frequencies
        begin
            if (done == 1)
                if (clk_count > 490000 & clk_count < 510000) // 200 Hz 500000
                    begin
                        decision <= 1;
                    end
                else if (clk_count > 90000 & clk_count < 110000) // 1000 Hz 100000
                    begin
                        decision <= 2;
                    end
                else if (clk_count > 19000 & clk_count < 21000) // 5000 Hz 20000
                    begin
                        decision <= 3;
                    end
                else if (clk_count > 10000 & clk_count < 16000) // 7000 Hz 14000
                    begin
                        decision <= 4;
                    end
                else
                    begin
                        decision <= 0;
                    end
        end
 
endmodule
