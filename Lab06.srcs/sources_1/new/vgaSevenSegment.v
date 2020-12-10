`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2020 04:24:02 PM
// Design Name: 
// Module Name: vgaSevenSegment
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

// x, y in [0,100]
module vgaSevenSegment(
    input [9:0] x,
    input [9:0] y,
    input [6:0] seg,
    output reg high
    );
    
    parameter SIZE = 10;
    parameter WIDTH = 80;
    
    initial
    begin
        high = 0;
    end
    
    always @(x, y)
    begin
        high = 0;
        
        if (x >= 0 && x < WIDTH && y >= 0 && y < SIZE && ~seg[0])
        begin
            high = 1;
        end
        
        if (x >= WIDTH - SIZE && x < WIDTH && y >= 0 && y < 50 && ~seg[1])
        begin
            high = 1;
        end
        
        if (x >= WIDTH - SIZE && x < WIDTH && y >= 50 && y < 100 && ~seg[2])
        begin
            high = 1;
        end
        
        if (x >= 0 && x < WIDTH && y >= 100 - SIZE && y < 100 && ~seg[3])
        begin
            high = 1;
        end
        
        if (x >= 0 && x < SIZE && y >= 50 && y < 100 && ~seg[4])
        begin
            high = 1;
        end
        
        if (x >= 0 && x < SIZE && y >= 0 && y < 50 && ~seg[5])
        begin
            high = 1;
        end
        
        if (x >= 0 && x < WIDTH && y >= 50 - (SIZE / 2) && y < 50 + (SIZE / 2) && ~seg[6])
        begin
            high = 1;
        end
        
        
    end
endmodule
