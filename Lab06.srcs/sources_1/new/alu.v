`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 10:36:22 AM
// Design Name: 
// Module Name: alu
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


module alu(
    input [15:0] A,
    input [15:0] B,
    input [2:0] alu_ops,
    output reg [16:0] S
    );
    
    reg [31:0] SS;
    reg Ssign;
    
    wire [15:0] absA, absB;
    wire signA, signB;
    
    abs absAmachine(A, absA, signA);
    abs absBmachine(B, absB, signB);
    
    wire [15:0] greater = (absA > absB ? absA : absB);
    wire [15:0] lesser = (absA > absB ? absB : absA);
    
    wire addSignB = (alu_ops == 2'b001 ? ~signB : signB);
    
    // wire greaterSign = (absA > absB ? signA : addSignB);
    // wire lesserSign = (absA > absB ? addSignB : signA);
    
    always @(absA, absB, signA, signB, addSignB, greater, lesser, alu_ops, SS)
    begin
        case (alu_ops)
            3'b000, 3'b001:
            begin
                if (signA == addSignB)
                begin
                    SS = greater + lesser;
                    Ssign = signA;
                end else begin
                    SS = greater - lesser;
                    Ssign = (absA > absB ? signA : addSignB);
                end
            end
            
            3'b010:
            begin
                SS = absA * absB;
                Ssign = signA ^ signB;
            end
            
            3'b011:
            begin
                if (absB == 0)
                begin
                    SS = 0;
                end else begin
                    SS = absA / absB;
                end
                
                Ssign = signA ^ signB;
            end
            
            default: 
            begin
                SS = absA;
                Ssign = signA;
            end
        endcase
        
        S = {SS > 9999 ? 1'b1 : 1'b0, Ssign == 1 ? -{1'b0, SS[14:0]} : {1'b0, SS[14:0]}};
        //$monitor("%b; A: %b %d, B: %b %d, alu_ops: %b -> S: %b %d", {addSignB, Ssign}, signA, absA, signB, absB, alu_ops, S[16:15], S[14:0]);
    end
endmodule
