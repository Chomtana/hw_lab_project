`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 08:47:57 PM
// Design Name: 
// Module Name: system
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


module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output RsTx,
    input clk,
    input RsRx
    );
    
    wire dpp; // Throw away dp from driver
    wire [7:0] uart;
    
    wire [15:0] A;
    wire [15:0] B;
    wire [2:0] alu_ops;
    wire [16:0] S;
    
    wire [15:0] absS;
    
    uartSystem uartSystem(clk, RsRx, RsTx, uart, A, B, alu_ops, S);
    //computeUnit computeUnit(uart, A, B, alu_ops, S);
    
    alu aluComponent(A, B, alu_ops, S);
    
    wire [19:0] tclk;
    
    assign tclk[0] = clk;
    
    genvar c;
    generate for(c=0;c<19;c=c+1)
    begin
        clockDiv fdiv(tclk[c], tclk[c+1]);
    end endgenerate

    assign dp = S[15];
    
    sevenSegment sevenSegment(tclk[19], {0, S[14:12]}, S[11:8], S[7:4], S[3:0], seg, dpp, an);
endmodule
