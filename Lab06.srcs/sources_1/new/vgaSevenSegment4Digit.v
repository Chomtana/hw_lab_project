`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2020 05:32:21 PM
// Design Name: 
// Module Name: vgaSevenSegment4Digit
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


module vgaSevenSegment4Digit(
    input [9:0] x,
    input [9:0] y,
    input [9:0] SCALER,
    input [16:0] num,
    output reg high
    );
    
    // startX = ((SEGMENT_SIZE / SCALER) + PADDING) * digit
    
    wire [16:0] bcdNum;
    
    parameter SEGMENT_SIZE = 80;
    parameter PADDING_SIZE = 20;
    
    wire [9:0] PADDING;
    wire [9:0] BLOCK_SIZE;
    
    wire [4:0] highDigit;
    wire [6:0] seg3, seg2, seg1, seg0;
    
    assign PADDING = PADDING_SIZE / SCALER;
    assign BLOCK_SIZE = ((SEGMENT_SIZE / SCALER) + PADDING);
    
    bcdMachine bcdMachine(num[15:0], bcdNum);

    segmentDecoder decoder3(bcdNum[15:12], seg3);
    segmentDecoder decoder2(bcdNum[11:8], seg2);
    segmentDecoder decoder1(bcdNum[7:4], seg1);
    segmentDecoder decoder0(bcdNum[3:0], seg0);
    
    vgaSevenSegment vgaSevenSegment4(x * SCALER, y, num[16] || bcdNum[16] ? 7'b0111111 : 7'b1111111, highDigit[4]);
    vgaSevenSegment vgaSevenSegment3((x - BLOCK_SIZE) * SCALER, y, num[16] ? 7'b0111111 : seg3, highDigit[3]);
    vgaSevenSegment vgaSevenSegment2((x - BLOCK_SIZE * 2) * SCALER, y, num[16] ? 7'b0111111 : seg2, highDigit[2]);
    vgaSevenSegment vgaSevenSegment1((x - BLOCK_SIZE * 3) * SCALER, y, num[16] ? 7'b0111111 : seg1, highDigit[1]);
    vgaSevenSegment vgaSevenSegment0((x - BLOCK_SIZE * 4) * SCALER, y, num[16] ? 7'b0111111 : seg0, highDigit[0]);
    
    always @(highDigit)
    begin
        high = 0;
        
        if (x >= 0 && x < BLOCK_SIZE)
        begin
            high = highDigit[4];
        end
        
        if (x >= BLOCK_SIZE && x < BLOCK_SIZE * 2)
        begin
            high = highDigit[3];
        end
        
        if (x >= BLOCK_SIZE * 2 && x < BLOCK_SIZE * 3)
        begin
            high = highDigit[2];
        end
        
        if (x >= BLOCK_SIZE * 3 && x < BLOCK_SIZE * 4)
        begin
            high = highDigit[1];
        end
        
        if (x >= BLOCK_SIZE * 4 && x < BLOCK_SIZE * 5)
        begin
            high = highDigit[0];
        end
    end
    
endmodule
