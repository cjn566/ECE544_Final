`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2014 05:37:46 PM
// Design Name: 
// Module Name: ball_collision_test
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


module ball_collision_test();

	parameter PERIOD = 10;
	
	reg clk, rst, up= 1'b0, down= 1'b0, left= 1'b0, right= 1'b0;
	wire [3:0] moves = {right, left, down, up};
	
	initial begin
		CLK = 1'b0;
		#(PERIOD/2);
		forever
			#(PERIOD/2) CLK = ~CLK;
	end
    
	initial begin
		rst = 1'b1;
		
		#100 rst = 1'b0;
		#100 up = 1'b1;
	end
	
   Ball ball
(
	map_value,	
	.clk(clk),
	.reset(rst),	
	.movement(moves),	
	.y_out,
	.x_out,
	
	.vid_row,		// video logic row address
	.vid_col,		// video logic column address
	.vid_pixel_out	// pixel (location) value
);
   
endmodule
