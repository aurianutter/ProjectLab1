`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2020 04:55:37 PM
// Design Name: 
// Module Name: ColorSensor
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


module ColorSensor(
    input clk,
    input intensity,
    output reg redOut,
    output reg greenOut,
    output reg blueOut,
    output reg done,
    input go,
    input reset,
    output reg s2,
    output reg s3
    );
    
    reg syncIntensity;
    reg oldIntensity;
    wire StartCount;
    reg [6:0] state = 0;
    reg [19:0] redCount;
    reg [19:0] blueCount;
    reg [19:0] greenCount;
    reg [19:0] clearCount;
    reg [6:0] redSafe;
    reg [6:0] blueSafe;
    reg [6:0] greenSafe;
    
    
    reg [19:0] numerator = 0;
    reg [19:0] denominator = 0;
    reg goPercent = 0;
    wire [6:0] answer;
    wire donePercent;
    
    reg [6:0] redPaperredFilter = 90;
    reg [6:0] redPaperblueFilter = 15;
    reg [6:0] redPapergreenFilter = 5;
    
    reg [6:0] bluePaperredFilter = 3;
    reg [6:0] bluePaperblueFilter = 70;
    reg [6:0] bluePapergreenFilter = 30;
    
    reg [6:0] greenPaperredFilter = 20;
    reg [6:0] greenPaperblueFilter = 15;
    reg [6:0] greenPapergreenFilter = 60;
    
    reg [8:0] redabs;
    reg [8:0] blueabs;
    reg [8:0] greenabs;
    
    
    // number4filter
    
    reg [6:0] num1;
    reg [6:0] num2;
    wire [6:0] ans;
    
    Percentage uut1(
    numerator,
    denominator,
    answer,
    goPercent,
    donePercent,
    clk,
    reset
    );
    
    absoluteValue uut2(
    num1,
    num2,
    ans
    );
    
    always @ (posedge clk)
        begin
            syncIntensity <= intensity;
            oldIntensity <= syncIntensity;
        end
        
    assign StartCount = (~oldIntensity & syncIntensity); //rising edge
        
    always @ (posedge clk)
        begin
            if (reset)
                begin
                    state <= 0;
                    numerator <= 0;
                    denominator <= 0;
                    goPercent <= 0;
                    redOut <= 0;
                    blueOut <= 0;
                    greenOut <= 0;
                end
            else
                begin
                    case (state)
                        0: if (go) 
                            begin
                                {done, redCount, blueCount, greenCount, clearCount} <= 0;
                                state <= 1;
                            end
                        1: // set red filter
                            begin
                                s2 <= 0;
                                s3 <= 0;
                                state <= 2;
                            end
                        2: if (StartCount)
                            begin
                                redCount <= 0;
                                state <= 3;
                            end
                        3: 
                            begin
                                redCount <= redCount + 1;
                                if (StartCount)
                                    state <= 4;
                            end
                        4: // set blue filter
                            begin
                                s2 <= 0;
                                s3 <= 1;
                                state <= 5;
                            end
                        5: if (StartCount)
                            begin
                                blueCount <= 0;
                                state <= 6;
                            end
                        6: 
                            begin
                                blueCount <= blueCount + 1;
                                if (StartCount)
                                    state <= 7;
                            end
                        7: // set green filter
                            begin
                                s2 <= 1;
                                s3 <= 1;
                                state <= 8;
                            end
                        8: if (StartCount)
                            begin
                                greenCount <= 0;
                                state <= 9;
                            end
                        9: 
                            begin
                                greenCount <= greenCount + 1;
                                if (StartCount)
                                    state <= 10;
                            end
                        10: // set clear filter
                            begin
                                s2 <= 1;
                                s3 <= 0;
                                state <= 11;
                            end
                        11: if (StartCount)
                            begin
                                clearCount <= 0;
                                state <= 12;
                            end
                        12: 
                            begin
                                clearCount <= clearCount + 1;
                                if (StartCount)
                                    state <= 13;
                            end
                        13:
                            begin
                                numerator <= clearCount;
                                denominator <= redCount;
                                goPercent <= 1;
                                state <= 14;
                            end
                        14:
                            begin
                               redSafe <= answer;
                               goPercent <= 0;
                               if (donePercent)
                                   state <= 15;
                            end
                        15:
                            begin
                                numerator <= clearCount;
                                denominator <= blueCount;
                                goPercent <= 1;
                                state <= 16;
                            end
                        16:
                           begin
                               blueSafe <= answer;
                               goPercent <= 0;
                               if (donePercent)
                                    state <= 17;
                            end 
                        17:
                            begin
                                numerator <= clearCount;
                                denominator <= greenCount;
                                goPercent <= 1;
                                state <= 18;
                            end
                        18:
                            begin
                               greenSafe <= answer;
                               goPercent <= 0;
                               redabs <= 0;
                               blueabs <= 0;
                               greenabs <= 0;
                               if (donePercent)
                                    state <= 19;
                            end 
                       19:
                            begin
                                num1 <= redSafe;
                                num2 <= redPaperredFilter;
                                state <= 20;
                            end
                        20:
                            begin
                                redabs <= ans;
                                num1 <= blueSafe;
                                num2 <= redPaperblueFilter;
                                state <= 21;
                            end
                        21:
                            begin
                                redabs <= ans + redabs;
                                num1 <= greenSafe;
                                num2 <= redPapergreenFilter;
                                state <= 22;
                            end
                        22:
                            begin
                                redabs <= ans + redabs;
                                num1 <= redSafe;
                                num2 <= bluePaperredFilter;
                                state <= 23;
                            end
                        23:
                            begin
                                blueabs <= ans;
                                num1 <= blueSafe;
                                num2 <= bluePaperblueFilter;
                                state <= 24;
                            end
                        24:
                            begin
                                blueabs <= ans + blueabs;
                                num1 <= greenSafe;
                                num2 <= bluePapergreenFilter;
                                state <= 25;
                            end
                        25:
                            begin
                                blueabs <= ans + blueabs;
                                num1 <= redSafe;
                                num2 <= greenPaperredFilter;
                                state <= 26;
                            end
                        26:
                            begin
                                greenabs <= ans;
                                num1 <= blueSafe;
                                num2 <= greenPaperblueFilter;
                                state <= 27;
                            end
                        27:
                            begin
                                greenabs <= ans + greenabs;
                                num1 <= greenSafe;
                                num2 <= greenPapergreenFilter;
                                state <= 28;
                            end
                        28:
                            begin
                                greenabs <= ans + greenabs;
                                state <= 29;
                            end
                        29:
                            begin
                                if (redabs < blueabs & redabs < greenabs)
                                    begin
                                        redOut <= 1;
                                        blueOut <= 0;
                                        greenOut <= 0;
                                        done <= 1;
                                    end
                                else if (blueabs < redabs & blueabs < greenabs)
                                    begin
                                        redOut <= 0;
                                        blueOut <= 1;
                                        greenOut <= 0;
                                        done <= 1;
                                    end
                                else if (greenabs < redabs & greenabs < blueabs)
                                    begin
                                        redOut <= 0;
                                        blueOut <= 0;
                                        greenOut <= 1;
                                        done <= 1;
                                    end
                            end
                    endcase
                end
        end
endmodule
