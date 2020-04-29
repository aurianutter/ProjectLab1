`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2020 08:04:49 PM
// Design Name: 
// Module Name: absoluteValue
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


module absoluteValue(
    input [6:0] num1,
    input [6:0] num2,
    output reg [6:0] ans
    );
    
    
    always @ (*)
        begin
            if (num1 < num2)
                begin
                    ans = num2 - num1;
                end
            else 
                begin
                    ans = num1 - num2;
                end
            end
    
endmodule
