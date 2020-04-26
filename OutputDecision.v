`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2020 06:23:44 PM
// Design Name: 
// Module Name: OutputDecision
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


module OutputDecision(
    input [2:0] finalAnswer,
    input finalDone,
    input clock,
    output reg [3:0] lightOut
    );
    
    initial begin
        lightOut = 0;
    end
    
    always @ (posedge clock)
        begin
            if (finalDone == 1) //if finalAnswer valid
                begin
                    if (finalAnswer == 0)
                        begin
                            lightOut <= 15; //all lights on if not reading frequency
                        end
                    else if (finalAnswer == 1)
                        begin
                            lightOut <= 1; //first light on for 200 Hz
                        end
                    else if (finalAnswer == 2)
                        begin
                            lightOut <= 2; // second light on for 1000 Hz
                        end
                    else if (finalAnswer == 3)
                        begin
                            lightOut <= 4; // third light on for 5000 Hz
                        end
                    else if (finalAnswer == 4)
                        begin
                            lightOut <= 8; // fourth light on for 7000 Hz
                        end
                    else
                        begin
                            lightOut <= 0; // no light on if not frequency
                        end
                end
        end
            
            
endmodule