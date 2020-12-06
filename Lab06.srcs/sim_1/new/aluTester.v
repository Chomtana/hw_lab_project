`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 05:32:30 PM
// Design Name: 
// Module Name: aluTester
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


module aluTester(

    );
    
    reg [15:0] A = 0;
    reg [15:0] B = 0;
    reg [2:0] alu_ops = 3'b111;
    
    wire [16:0] S;
    
    alu aluMachine(A, B, alu_ops, S);
    
    initial
    begin
        #1
        A = 3;
        B = 13;
        
        #1
        alu_ops = 3'b000;
        
        #1
        alu_ops = 3'b001;
        
        #1
        alu_ops = 3'b010;
        
        #1
        alu_ops = 3'b011;
        
        #1
        A = 13;
        B = 3;
        
        #1
        alu_ops = 3'b000;
        
        #1
        alu_ops = 3'b001;
        
        #1
        alu_ops = 3'b010;
        
        #1
        alu_ops = 3'b011;
        
        #1
        A = -13;
        B = -3;
        
        #1
        alu_ops = 3'b000;
        
        #1
        alu_ops = 3'b001;
        
        #1
        alu_ops = 3'b010;
        
        #1
        alu_ops = 3'b011;
        
        #1
        A = -13;
        B = 3;
        
        #1
        alu_ops = 3'b000;
        
        #1
        alu_ops = 3'b001;
        
        #1
        alu_ops = 3'b010;
        
        #1
        alu_ops = 3'b011;
        
        #1
        A = 13;
        B = -3;
        
        #1
        alu_ops = 3'b000;
        
        #1
        alu_ops = 3'b001;
        
        #1
        alu_ops = 3'b010;
        
        #1
        alu_ops = 3'b011;
        
        #1
        A = 13;
        B = 0;
        
        #1
        alu_ops = 3'b000;
        
        #1
        alu_ops = 3'b001;
        
        #1
        alu_ops = 3'b010;
        
        #1
        alu_ops = 3'b011;
        
        #1
        A = 0;
        B = -13;
        
        #1
        alu_ops = 3'b000;
        
        #1
        alu_ops = 3'b001;
        
        #1
        alu_ops = 3'b010;
        
        #1
        alu_ops = 3'b011;
    
    end
    
endmodule
