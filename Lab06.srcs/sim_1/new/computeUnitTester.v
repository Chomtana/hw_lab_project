`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 08:10:44 PM
// Design Name: 
// Module Name: computeUnitTester
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


module computeUnitTester(

    );
    
    reg [7:0]K_0 = 8'h30;
    
    reg [7:0]K_PLUS = 8'h2b;
    reg [7:0]K_MINUS = 8'h2d;
    reg [7:0]K_MUL = 8'h2a;
    reg [7:0]K_DIV = 8'h2f;
    reg [7:0]K_ENTER = 8'h0a;
    reg [7:0]K_C = 8'h63;
    reg [7:0]K_ESC = 8'h1b;
    reg [7:0]K_BACKSPACE = 8'h08;
    
    reg [7:0] uart = 0;
    
    wire [16:0] S;
    wire [15:0] A, B;
    wire [2:0] alu_ops;
    
    computeUnit controller(uart, A, B, alu_ops, S);
    
    initial
    begin
        #1
        uart = K_0 + 8;
        
        #1
        uart = 0;
        
        #1
        uart = K_0 + 1;
        
        #1
        uart = 0;
        
        #1
        uart = K_PLUS;
        
        #1
        uart = 0;
        
        #1
        uart = K_0;
        
        #1
        uart = 0;
        
        #1
        uart = K_0 + 2;
        
        #1
        uart = 0;
        
        #1
        uart = K_0;
        
        #1
        uart = 0;
        
        #1
        uart = K_BACKSPACE;
        
        #1
        uart = 0;
        
        #1
        uart = K_0;
        
        #1
        uart = 0;
        
        #1
        uart = K_0;
        
        #1
        uart = 0;
        
        #1
        uart = K_0;
        
        #1
        uart = 0;
        
        #1
        uart = K_0;
        
        #1
        uart = 0;
    
        #1
        $finish;
    end
endmodule
