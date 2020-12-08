`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2020 10:06:54 AM
// Design Name: 
// Module Name: bcdMachine
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


module bcdMachine(
    input [15:0] num,
    output [16:0] out
    );
    
    wire [15:0] absNum;
    
    abs abs(num, absNum, out[16]);
    
    assign out[15:12] = absNum[14:0] / 1000;
    assign out[11:8] = (absNum[14:0] / 100) % 10;
    assign out[7:4] = (absNum[14:0] / 10) % 10;
    assign out[3:0] = absNum[14:0] % 10;
endmodule
