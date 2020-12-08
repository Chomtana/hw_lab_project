`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2020 08:47:57 PM
// Design Name: 
// Module Name: system
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


module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output RsTx,
    output wire hsync, vsync,
	output wire [11:0] rgb,
    input clk,
    input RsRx
    );
    
    parameter WIDTH = 640;
	parameter HEIGHT = 480;
		
	// register for Basys 2 8-bit RGB DAC 
	reg [11:0] rgb_reg;
	reg reset = 0;
	wire [9:0] x, y;

	// video status output from vga_sync to tell when to route out rgb signal to DAC
	wire video_on;
    wire p_tick;
	// instantiate vga_sync
	vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(p_tick), .x(x), .y(y));
	
	reg state = 0;
	reg [11:0] top_color = 0;

    
    wire dpp; // Throw away dp from driver
    wire [7:0] uart;
    
    wire [15:0] A;
    wire [15:0] B;
    wire [2:0] alu_ops;
    wire [16:0] S;
    
    wire [15:0] absS;
    
    uartSystem uartSystem(clk, RsRx, RsTx, uart, A, B, alu_ops, S[15:0]);
    //computeUnit computeUnit(uart, A, B, alu_ops, S);
    
    alu aluComponent(A, B, alu_ops, S);
    
    wire [19:0] tclk;
    
    assign tclk[0] = clk;
    
    genvar c;
    generate for(c=0;c<19;c=c+1)
    begin
        clockDiv fdiv(tclk[c], tclk[c+1]);
    end endgenerate
    
    wire [16:0] Sbcd;
    
    bcdMachine bcdMachine(S[15:0], Sbcd);

    assign dp = Sbcd[16];
    assign rgb = (video_on) ? rgb_reg : 12'b0;
    
    sevenSegment sevenSegment(tclk[19], Sbcd[15:12], Sbcd[11:8], Sbcd[7:4], Sbcd[3:0], seg, dpp, an);
endmodule
