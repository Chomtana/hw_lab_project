`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: Computer Engineering Department, Chulalongkorn University
// Engineer: Pollawat Hongwimol
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
    output RsTx
    );
    
    reg [7:0]K_0 = 8'h30;            //0
    
    reg [7:0]K_UP = 8'h77;            //w
    reg [7:0]K_DOWN = 8'h73;          //s
    reg [7:0]K_RIGHT = 8'h64;         //d
    reg [7:0]K_LEFT = 8'h61;          //a
        
    reg [7:0]K_WHITE = 8'h20;         //SPACE
    reg [7:0]K_MAGENTA = 8'h6d;       //m
    reg [7:0]K_CYAN = 8'h63;          //c
    reg [7:0]K_YELLOW = 8'h79;        //y
    
    reg ena, last_rec;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire sent, received, baud;
    
    
    baudrate_gen baudrate_gen(clk, baud);
    receiver receiver(baud, RsRx, received, data_out);
    transmitter transmitter(baud, data_in, ena, sent, RsTx);

    always @(posedge baud)
    begin
        if (ena == 1) begin
            ena = 0;
            data_in = 0;
        end
        
        if (~last_rec & received) begin
            data_in = data_out;
            ena = 1;
        end
        last_rec = received;
    end
    
endmodule
