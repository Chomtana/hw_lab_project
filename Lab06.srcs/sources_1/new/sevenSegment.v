`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2020 09:25:02 AM
// Design Name: 
// Module Name: sevenSegment
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


module sevenSegment(
    input clk,
    input [3:0] num3,
    input [3:0] num2,
    input [3:0] num1,
    input [3:0] num0,
    output [6:0] seg,
    output dp,
    output [3:0] an
    );
    
    reg [3:0] an;
    reg [1:0] state;
    reg [3:0] activeNum;
    
    initial
    begin
        state = 2'b00;
        activeNum = num0;
    end
    
    assign dp = 1;
    
    segmentDecoder decoder(activeNum, seg);
    
    always @(posedge clk)
    begin
        state = state + 1;
    end
    
    always @(state)
    begin
        case (state)
            2'b00: activeNum = num0;
            2'b01: activeNum = num1;
            2'b10: activeNum = num2;
            2'b11: activeNum = num3;
        endcase
        
        case (state)
            2'b00: an = 4'b1110;
            2'b01: an = 4'b1101;
            2'b10: an = 4'b1011;
            2'b11: an = 4'b0111;
        endcase
    end
endmodule
