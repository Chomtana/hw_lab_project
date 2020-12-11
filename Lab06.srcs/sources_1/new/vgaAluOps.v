`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2020 10:32:55 PM
// Design Name: 
// Module Name: vgaAluOps
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


module vgaAluOps(
    input [9:0] x,
    input [9:0] y,
    input [2:0] alu_ops,
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
        
        if (WIDTH - x <= y + SIZE/2 && y <= WIDTH - x + SIZE/2 && (alu_ops == 3'b010 || alu_ops == 3'b011))
        begin
            high = 1;
        end
        
        if (x <= y + SIZE/2 && y <= x + SIZE/2 && (alu_ops == 3'b010))
        begin
            high = 1;
        end
        
        if (x >= (WIDTH - SIZE) / 2 && x < (WIDTH + SIZE) / 2 && y >= 0 && y < 100 && (alu_ops == 3'b000))
        begin
            high = 1;
        end
        
        if (x >= 0 && x < WIDTH && y >= 50 - (SIZE / 2) && y < 50 + (SIZE / 2) && (alu_ops == 3'b000 || alu_ops == 3'b001))
        begin
            high = 1;
        end
        
        
    end
endmodule
