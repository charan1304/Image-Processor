`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:24:26 06/15/2024
// Design Name: 
// Module Name:    image_processing 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module image_processing( 
clk,reset,sel_mod,red,green,blue,done_in,done_out,val,red_o,green_o,blue_o
);

input clk,reset,done_in;
input [2:0] sel_mod;
input [7:0] red,green,blue;
input [7:0] val;
output reg done_out;
output reg [7:0] red_o,green_o,blue_o;
reg [8:0] red_x,green_x,blue_x;

always @ (posedge clk)
	begin
		if (sel_mod == 3'b000)
			begin
				if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else
					begin
						if (done_in == 1)
							begin
								red_o <= (red>>2)+(red>>5)+(green>>1)+(green>>4)+(blue>>4)+(blue>>5);
								green_o <= (red>>2)+(red>>5)+(green>>1)+(green>>4)+(blue>>4)+(blue>>5);
								blue_o <= (red>>2)+(red>>5)+(green>>1)+(green>>4)+(blue>>4)+(blue>>5);
								done_out=1;
							end
						else
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end
			end
		else if (sel_mod ==3'b001)
			begin
				if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else 
					begin
						if (done_in == 1)
							begin
								red_x = red + val;
								green_x = green + val;
								blue_x = blue + val;
								if(red_x > 255)
									red_o <= 255;
								else
									red_o <= red_x;
								if(green_x > 255)
									green_o <= 255;
								else
									green_o <= green_x;
								if(blue_x > 255)	
									blue_o <= 255;
								else 
									blue_o <= blue_x;
								done_out <= 1;	
							end
						else 
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end		
			end
		else if (sel_mod ==3'b010)
			begin
				if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else 
					begin
						if (done_in == 1)
							begin
								red_x = red - val;
								green_x = green - val;
								blue_x = blue - val;
								if(red_x < 0)
									red_o <= 0;
								else
									red_o <= red_x;
								if(green_x < 0 )
									green_o <= 0;
								else
									green_o <= green_x;
								if(blue_x < 0 )	
									blue_o <= 0;
								else 
									blue_o <= blue_x;
								done_out <= 1;	
							end
						else 
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end		
			end
			else if (sel_mod == 3'b011)
				begin
						if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else 
					begin
						if (done_in == 1)
							begin
							red_o <= 255 - red;
							green_o <= 255 - green;
							blue_o <= 255 - blue;
							done_out <= 1;
							end	
						else 
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end		
			end
		else if (sel_mod == 3'b100)
				begin
						if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else 
					begin
						if (done_in == 1)
							begin
							red_o <= 0;
							green_o <= green;
							blue_o <= blue;
							done_out <= 1;
							end	
						else 
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end		
			end
		else if (sel_mod == 3'b101)
				begin
						if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else 
					begin
						if (done_in == 1)
							begin
							red_o <= red;
							green_o <= 0;
							blue_o <= blue;
							done_out <= 1;
							end	
						else 
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end		
			end
		else if (sel_mod == 3'b110)
				begin
						if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else 
					begin
						if (done_in == 1)
							begin
							red_o <= red;
							green_o <= green;
							blue_o <= 0;
							done_out <= 1;
							end	
						else 
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end		
			end
		else if (sel_mod == 3'b111)
				begin
						if (reset == 1)
					begin
						red_o <= 0;
						green_o <= 0;
						blue_o <= 0 ;
						done_out <= 0;
					end
				else 
					begin
						if (done_in == 1)
							begin
							red_o <= red;
							green_o <= green;
							blue_o <= blue;
							done_out <= 1;
							end	
						else 
							begin
								red_o <= 0;
								green_o <= 0;
								blue_o <= 0;
								done_out <= 0;
							end
					end		
			end
	end
	

endmodule
