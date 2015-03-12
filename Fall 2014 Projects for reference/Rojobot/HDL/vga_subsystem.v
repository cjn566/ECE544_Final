`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Authors: Colten Nye, Hoa Quach
// 
// Create Date: 10/31/2014 01:54:46 PM
// Module Name: vga_subsystem
// Project Name: ECE 540 Project 2
// Description:
//		This module is the top level for the VGA display components, including
//		the clock divider, display timing generator, icon module, and colorizer
// 		
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_subsystem(
    input sys_clk,
    input sys_rst,
    input [7:0] LocX_reg,
    input [7:0] LocY_reg,
    input [2:0] BotInfo_reg,
    input [1:0] world_pixel,
    output vert_sync,
    output horiz_sync,
    output [9:0] pixel_row,
    output [9:0] pixel_column,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );

// Internal connections
wire new_clk;           // 25MHz
wire [1:0] icon;
wire video_on;

    // Clock divider 100MHz -> 25MHz
  clk_wizard clk_wiz
   (
    .clk_in1(sys_clk),
    .clk_out1(new_clk),
    .reset(sys_rst),
    .locked(locked)
    );
    
    // Display Timing Generator
    dtg dtg(
        .clock(new_clk),
        .rst(sys_rst),
        .horiz_sync(horiz_sync),
        .vert_sync(vert_sync),
        .video_on(video_on),        
        .pixel_row(pixel_row),
        .pixel_column(pixel_column)
    );
	
	// Icon
	draw_icon di(
	    .vert(pixel_row),
		.horz(pixel_column),
		.clk (new_clk),
		.bot_LocX(LocX_reg), 
		.bot_LocY(LocY_reg),
		.bot_Orie(BotInfo_reg),
		.icon_out(icon)  
	);
    
	// Colorizer combines the wor
    colorizer c(
        .video_on(video_on),
        .world_pixel(world_pixel),
        .icon(icon),
        .red(red),
        .green(green),
        .blue(blue)
    );

endmodule