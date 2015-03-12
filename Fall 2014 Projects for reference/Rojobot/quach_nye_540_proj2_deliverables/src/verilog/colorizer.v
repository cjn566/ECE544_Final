`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Authors: Colten Nye, Hoa Quach
// 
// Create Date: 10/31/2014 03:38:07 PM
// Module Name: colorizer
// Project Name: ECE 540 Project 2
// Description: 
// 		Combines the input pixel codes from the world map and the rojobot icon,
//		displays the result to VGA.
// 
//////////////////////////////////////////////////////////////////////////////////


module colorizer(
    input video_on,
    input [1:0] world_pixel,
    input [1:0] icon,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );
    
    // Pixel color definitions
    parameter WORLD_COLOR_BG        = 12'hFFF;
    parameter WORLD_COLOR_LINE      = 12'h000;
    parameter WORLD_COLOR_OBS       = 12'h55A;
    parameter ICON_COLOR_1          = 12'hF00;
    parameter ICON_COLOR_2          = 12'h0F0;
    parameter ICON_COLOR_3          = 12'h00F;
    parameter BLK			        = 12'h000;
    
	// Pixel Addresses
    parameter WORLD_ADDR_BG         = 2'b00; 
    parameter WORLD_ADDR_LINE		= 2'b01; 
    parameter WORLD_ADDR_OBS		= 2'b10; 
    parameter ICON_ADDR_TP          = 2'b00; 
    parameter ICON_ADDR_1           = 2'b01; 
    parameter ICON_ADDR_2           = 2'b10; 
    parameter ICON_ADDR_3           = 2'b11;
    
    reg [11:0] color;
    assign {red,green,blue} = color;	// Split the color reg into 3 outputs
    
    always @(*) begin
        if (video_on == 1'b0) begin     // Video is off, display black
            color 	<= BLK;
        end
        else begin
            case (icon)
				ICON_ADDR_TP		: begin			// Icon is transparent, use world input
					case (world_pixel)
						WORLD_ADDR_BG	: color <= WORLD_COLOR_BG;
						WORLD_ADDR_LINE	: color <= WORLD_COLOR_LINE;
						WORLD_ADDR_OBS	: color <= WORLD_COLOR_OBS;
					endcase
					end
				// Icon is not transparent, use the icon color
				ICON_ADDR_1			: color <= ICON_COLOR_1;
				ICON_ADDR_2			: color <= ICON_COLOR_2;
				ICON_ADDR_3			: color <= ICON_COLOR_3;
            endcase
        end
    end
    
endmodule
