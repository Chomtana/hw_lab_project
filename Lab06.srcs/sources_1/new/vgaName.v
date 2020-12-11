`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2020 09:39:51 AM
// Design Name: 
// Module Name: vgaName
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


module vgaName(
    input [9:0] x,
    input [9:0] y,
    input [9:0] SCALER,
    output reg high
    );
    
    // startX = ((SEGMENT_SIZE / SCALER) + PADDING) * digit
    
    parameter SEGMENT_SIZE = 80;
    parameter PADDING_SIZE = 20;
    
    wire [9:0] PADDING;
    wire [9:0] BLOCK_SIZE;
    
    wire [6:0] highDigit;
    
    assign PADDING = PADDING_SIZE / SCALER;
    assign BLOCK_SIZE = ((SEGMENT_SIZE / SCALER) + PADDING);
    
    vgaSevenSegment vgaSevenSegment6(x * SCALER, y * SCALER, ~7'b0111001, highDigit[6]);
    vgaSevenSegment vgaSevenSegment5((x - BLOCK_SIZE) * SCALER, y * SCALER, ~7'b1110110, highDigit[5]);
    vgaSevenSegment vgaSevenSegment4((x - BLOCK_SIZE * 2) * SCALER, y * SCALER, 7'b1000000, highDigit[4]);
    vgaSevenSegment vgaSevenSegment3((x - BLOCK_SIZE * 3) * SCALER, y * SCALER, ~7'b0110111, highDigit[3]);
    vgaSevenSegment vgaSevenSegment2((x - BLOCK_SIZE * 4) * SCALER, y * SCALER, ~7'b0111001, highDigit[2]);
    vgaSevenSegment vgaSevenSegment1((x - BLOCK_SIZE * 5) * SCALER, y * SCALER, ~7'b1110111, highDigit[1]);
    vgaSevenSegment vgaSevenSegment0((x - BLOCK_SIZE * 6) * SCALER, y * SCALER, ~7'b0111000, highDigit[0]);
    
    always @(highDigit)
    begin
        high = 0;
        
        if (x >= 0 && x < BLOCK_SIZE)
        begin
            high = highDigit[6];
        end
        
        if (x >= BLOCK_SIZE && x < BLOCK_SIZE * 2)
        begin
            high = highDigit[5];
        end
        
        if (x >= BLOCK_SIZE * 2 && x < BLOCK_SIZE * 3)
        begin
            high = highDigit[4];
        end
        
        if (x >= BLOCK_SIZE * 3 && x < BLOCK_SIZE * 4)
        begin
            high = highDigit[3];
        end
        
        if (x >= BLOCK_SIZE * 4 && x < BLOCK_SIZE * 5)
        begin
            high = highDigit[2];
        end
        
        if (x >= BLOCK_SIZE * 5 && x < BLOCK_SIZE * 6)
        begin
            high = highDigit[1];
        end
        
        if (x >= BLOCK_SIZE * 6 && x < BLOCK_SIZE * 7)
        begin
            high = highDigit[0];
        end
    end
    
endmodule
