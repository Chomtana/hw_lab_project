`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2020 08:19:05 AM
// Design Name: 
// Module Name: clockDiv
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


module clockDiv(
    input clk,
    output clkDiv
    );
    
    reg clkDiv;
    
    initial
    begin
        clkDiv=0;
    end
    
    always @(posedge clk)
    begin
        clkDiv = ~clkDiv;
    end
endmodule
