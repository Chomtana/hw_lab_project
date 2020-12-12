`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: Computer Engineering Department, Chulalongkorn University
// Engineer: Chomtana Chanjaraswichai
// 
// Create Date: 04/12/2020 03:03:19 AM
// Design Name: 
// Module Name: uartSystem
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
module uartSystem(
    input clk,
    input RsRx,
    output RsTx,
    output reg [7:0] uart,
    output reg [15:0] A,
    output reg [15:0] B,
    output reg [2:0] alu_ops,
    input [16:0] S,
    input reset
    );
    
    reg [2:0] st = 0;
    
    parameter K_0 = 8'h30;
    
    parameter K_PLUS = 8'h2b;
    parameter K_MINUS = 8'h2d;
    parameter K_MUL = 8'h2a;
    parameter K_DIV = 8'h2f;
    parameter K_ENTER = 8'h0a;
    parameter K_C = 8'h63;
    parameter K_ESC = 8'h1b;
    parameter K_BACKSPACE = 8'h08;
    parameter K_S = 8'h73;
    
    reg ena, last_rec;
    
    wire [7:0] data_out;
    wire sent, received, baud;
    
    baudrate_gen baudrate_gen(clk, baud);
    receiver receiver(baud, RsRx, received, data_out);
    transmitter transmitter(baud, uart, ena, sent, RsTx);
    
    initial
    begin
        A = 0;
        B = 0;
        alu_ops = 3'b111;
    end

    always @(posedge baud)
    begin
        if (ena == 1) begin
            ena = 0;
            uart = 0;
        end
        
        if (~last_rec & received) begin
            uart = data_out;
            ena = 1;
            
            if (uart >= K_0 && uart <= K_0 + 9)
            begin
                case (st)
                    2'b00: A = (A < 1000 ? A * 10 + (uart - K_0) : A);
                    2'b01: B = (B < 1000 ? B * 10 + (uart - K_0) : B);
                endcase
            end
            
            if (uart == K_S)
            begin
                case (st)
                    2'b00: A = -A;
                    2'b01: B = -B;
                endcase
            end
            
            if (uart == K_PLUS || uart == K_MINUS || uart == K_MUL || uart == K_DIV || uart == K_ENTER)
            begin
                st = st + 1;
                
                if (st > 1)
                begin
                    A = (S[16] == 1 ? 16'b0 : S[15:0]);
                    B = 0;
                    st = 1;
                end
                
                case (uart)
                    K_PLUS: alu_ops = 3'b000;
                    K_MINUS: alu_ops = 3'b001;
                    K_MUL: alu_ops = 3'b010;
                    K_DIV: alu_ops = 3'b011;
                    K_ENTER: alu_ops = 3'b111;
                endcase
            end
            
            if (uart == K_C || uart == K_ESC)
            begin
                st = 0;
                A = 0;
                B = 0;
                alu_ops = 3'b111;
            end
            
            if (uart == K_BACKSPACE)
            begin
                if (st == 2'b01 && B == 0) begin
                    st = 0;
                    alu_ops = 3'b111;
                end else begin        
                    case (st)
                        2'b00: A = A / 10;
                        2'b01: B = B / 10;
                    endcase
                end
            end
        end
        last_rec = received;
        
        if (reset) begin
            st = 0;
            A = 0;
            B = 0;
            alu_ops = 3'b111;
        end
    end
    
endmodule
