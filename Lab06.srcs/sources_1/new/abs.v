`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 10:32:37 AM
// Design Name: 
// Module Name: abs
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


module abs(
    input [15:0] num,
    output [15:0] abs_num,
    output sign_num
    );
    
    assign sign_num = num[15];
    assign abs_num = (num[15] == 1 ? -num : num);
endmodule
