`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 08:01:15 PM
// Design Name: 
// Module Name: computeUnit
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


module computeUnit(
    input [7:0] uart,
    output [15:0] A,
    output [15:0] B,
    output [2:0] alu_ops,
    output [16:0] S
    );
    
    ioController io(uart, S, A, B, alu_ops);
    alu aluComponent(A, B, alu_ops, S);
endmodule
