`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2020 10:12:13 AM
// Design Name: 
// Module Name: bcdTester
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


module bcdTester(

    );
    
    reg [15:0] num = 0;
    wire bcdSign;
    wire [15:0] bcd;
    
    bcdMachine bcdMachine(num, {bcdSign, bcd});
    
    initial
    begin
        #1
        num = 1;
        
        #1
        num = -1;
        
        #1
        num = 12;
        
        #1
        num = -12;
        
        #1
        num = 345;
        
        #1
        num = -345;
        
        #1
        num = 6789;
        
        #1
        num = -6789;
        
        #1
        num = 9999;
        
        #1
        num = -9999;
        
        #1
        $finish;
    end
endmodule
