//////////////////////////////////////////////////////////////////////////////////
// Authors: Colten Nye, Hoa Quach
// 
// Create Date: 10/31/2014 10:07:18 PM
// Module Name: Nexys4fpga
// Project Name: ECE 540 Project 2
// Description: 
// 		Top level module for the RojoBot simulator
// 
//////////////////////////////////////////////////////////////////////////////////

module Nexys4fpga (
	input 				clk,                 	// 100MHz clock from on-board oscillator
	input				btnL, btnR,				// pushbutton inputs - left (db_btns[4])and right (db_btns[2])
	input				btnU, btnD,				// pushbutton inputs - up (db_btns[3]) and down (db_btns[1])
	input				btnC,					// pushbutton inputs - center button -> db_btns[5]
	input				btnCpuReset,			// red pushbutton input -> db_btns[0]
	input	[15:0]		sw,						// switch inputs
	
	output	[15:0]		led,  					// LED outputs	
	
	output 	[6:0]		seg,					// Seven segment display cathode pins
	output              dp,
	output	[7:0]		an,						// Seven segment display anode pins	
	
	output	[7:0]		JA,						// JA Header
	
	output  [3:0]		vgaRed,
	output  [3:0]		vgaGreen,
	output  [3:0]		vgaBlue,
	output				Hsync, Vsync
); 

	// parameter
	parameter SIMULATE = 0;

	// internal variables
	wire 	[15:0]		db_sw;					// debounced switches
	wire 	[5:0]		db_btns;				// debounced buttons
	
	wire				sysclk;					// 100MHz clock from on-board oscillator	
	wire				sysreset;				// system reset signal - asserted high to force reset
	
	wire 	[4:0]		dig7, dig6,
						dig5, dig4,
						dig3, dig2, 
						dig1, dig0;				// display digits
	wire 	[7:0]		decpts;					// decimal points
	wire    [7:0]       segs_int;              // sevensegment module the segments and the decimal point
	
	//wires for kcpsm6
	wire [11:0]	address;			//proj2demo
	wire [17:0]	instruction;		//proj2demo
	wire 		bram_enable;		//proj2demo
	wire [7:0]	port_id;			//n4_bot_if
	wire [7:0]	out_port;			//n4_bot_if
	wire [7:0]	in_port;			//n4_bot_if
	wire 		write_strobe;		//n4_bot_if
	wire 		k_write_strobe;		//n4_bot_if
	wire 		read_strobe;		//n4_bot_if
	wire 		interrupt;			//n4_bot_if
	wire 		interrupt_ack;		//n4_bot_if
	wire 		kcpsm6_reset;
	wire 		rdl;
	wire 		kcpsm6_sleep;
	
	//wires for bot
	wire [7:0]	motctl;
	wire [7:0]	locX;
	wire [7:0]	locY;
	wire [7:0]	sensors;
	wire [7:0]	botinfo;
	wire [7:0]	lmdist;
	wire [7:0]	rmdist;
	wire 		upd_sysreg;
	wire [9:0]	vid_row;				//video ctrlr
	wire [9:0]	vid_col;				//video ctrlr
	wire [1:0]	vid_pixel_out;			//video ctrlr
	
	wire [9:0]	vid_rowx4;				//video ctrlr
	wire [9:0]	vid_colx4;				//video ctrlr
	
	wire [1:0] icon;

		
/******************************************************************/
/* THIS SECTION SHOULDN'T HAVE TO CHANGE FOR LAB 1                */
/******************************************************************/			
	// global assigns
	assign  kcpsm6_sleep = 0;
	assign	sysclk = clk;
	assign 	sysreset = db_btns[0]; // btnCpuReset is asserted low
	
	assign dp = segs_int[7];
	assign seg = segs_int[6:0];
	
	assign	JA = {sysclk, sysreset, 6'b000000};
	
	// Quarter the VGA resolution to match map size for bot.v
	assign vid_rowx4 = vid_row >> 2;
	assign vid_colx4 = vid_col >> 2;
	
	//instantiate the debounce module
	debounce
	#(
		.RESET_POLARITY_LOW(1),
		.SIMULATE(SIMULATE)
	)  	DB
	(
		.clk(sysclk),	
		.pbtn_in({btnC,btnL,btnU,btnR,btnD,btnCpuReset}),
		.switch_in(sw),
		.pbtn_db(db_btns),
		.swtch_db(db_sw)
	);	
		
	// instantiate the 7-segment, 8-digit display
	sevensegment
	#(
		.RESET_POLARITY_LOW(1),
		.SIMULATE(SIMULATE)
	) SSB
	(
		// inputs for control signals
		.d0(dig0),
		.d1(dig1),
 		.d2(dig2),
		.d3(dig3),
		.d4(dig4),
		.d5(dig5),
		.d6(dig6),
		.d7(dig7),
		.dp(decpts),
		
		// outputs to seven segment display
		.seg(segs_int),			
		.an(an),
		
		// clock and reset signals (100 MHz clock, active high reset)
		.clk(sysclk),
		.reset(sysreset),
		
		// output for simulation only
		.digits_out()//digits_out)
	);

/******************************************************************/
/* CHANGE THIS DEFINITION FOR YOUR LAB 1                          */
/******************************************************************/							
	// instantiate RojoBot module						
	bot	bot2(
		.MotCtl_in 		(motctl),
		.LocX_reg		(locX),
		.LocY_reg		(locY),
		.Sensors_reg	(sensors),
		.BotInfo_reg	(botinfo),
		.LMDist_reg		(lmdist),
		.RMDist_reg 	(rmdist),
		.vid_row		(vid_rowx4),
		.vid_col		(vid_colx4),
		.vid_pixel_out	(vid_pixel_out),
		.clk			(sysclk),
		.reset			(~sysreset),
		.upd_sysregs	(upd_sysreg)
	);
	
	// cpu for controlling the bot
	kcpsm6 #(
		.interrupt_vector (12'h3FF),
  		.scratch_pad_memory_size (64),
  		.hwbuild (8'h00)
	)
  	processor1 (
		.address 			(address),
  		.instruction 		(instruction),
  		.bram_enable 		(bram_enable),
  		.port_id 				(port_id),
  		.write_strobe 	(write_strobe),
  		.k_write_strobe (k_write_strobe),
  		.out_port 			(out_port),
  		.read_strobe 		(read_strobe),
  		.in_port 				(in_port),
  		.interrupt 			(interrupt),
  		.interrupt_ack 	(interrupt_ack),
  		.reset 					(kcpsm6_reset),
  		.sleep					(kcpsm6_sleep),
  		.clk 						(sysclk)
	);
	
	// reset logic for cpu
	assign kcpsm6_reset = ~sysreset | rdl;
   
	// cpu program code
	proj2 hqproj2(	
		.address		(address),
		.enable			(bram_enable),
		.instruction	(instruction),
		.clk			(sysclk),
		.rdl			(rdl)	
	);
		
	// interface between cpu and bot simulator
	nexys4_bot_if hq_n4_bot_if (    
		.clk (sysclk),
		.reset (~sysreset),
		.pb_port_id (port_id),
		.pb_out_port (out_port),
		.pb_k_write_strobe (k_write_strobe),
		.pb_write_strobe (write_strobe),
		.pb_read_strobe (read_strobe),
		.pb_interrupt_ack (interrupt_ack),
		.bot_locX (locX),
		.bot_locY (locY),
		.bot_botinfo (botinfo),
		.bot_sensors (sensors),
		.bot_lmdist (lmdist),
		.bot_rmdist (rmdist),
		.bot_upd_sysreg (upd_sysreg),
		.db_btns (db_btns[5:1]),
		.db_sw (db_sw),		
		
		.bot_motctl (motctl),
		.pb_in_port (in_port),
		.pb_interrupt (interrupt),
		.dig0 (dig0),
		.dig1 (dig1),
		.dig2 (dig2),
		.dig3 (dig3),
		.dig4 (dig4),
		.dig5 (dig5),
		.dig6 (dig6),
		.dig7 (dig7),
		.dp (decpts),
		.led (led)
	);

	// VGA sub-system
	vga_subsystem vga(
		.sys_clk(sysclk),
		.sys_rst(~sysreset),
		.LocX_reg(locX),
		.LocY_reg(locY),
		.BotInfo_reg(botinfo[2:0]),
		.world_pixel(vid_pixel_out),
		.vert_sync(Vsync),
		.horiz_sync(Hsync),
		.pixel_row(vid_row),
		.pixel_column(vid_col),
		.red(vgaRed),
		.green(vgaGreen),
		.blue(vgaBlue)
	);
	


endmodule