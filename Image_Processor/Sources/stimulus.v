`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:52:13 06/15/2024
// Design Name:   image_processing
// Project Name:  Image_Processing
// Target Device:  
// Tool versions:  
// Description: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stimulus;
	
	// Outputs
	wire done_out;
	wire [7:0] red_o,green_o,blue_o;
	wire [23:0] douta;
	
	reg clk,reset,done_in,rsta,ena;
	reg [0:0] wea;
	reg [7:0] red,green,blue;
	reg [2:0] sel_mod;
	reg [7:0] val;
	reg [14:0] addra;
	reg [23:0] dina;
	
	reg [23:0] din [18399:0];

	// Instantiate the Unit Under Test (UUT)
	image_processing uut (.clk(clk),.reset(reset),.sel_mod(sel_mod),.red(red),.green(green),.blue(blue),.done_in(done_in),.done_out(done_out),.val(val),.red_o(red_o),.green_o(green_o),.blue_o(blue_o));
	image bram (.clka(clk),.rsta(rsta),.ena(ena),.wea(wea),.addra(addra),.dina(dina),.douta(douta));
	
	initial 
		clk = 0;
	
	always begin
		#0.01 clk = !clk;
	end
	
	initial begin
		reset = 0;
		done_in = 0;
		rsta = 0;
		ena = 0;
		wea = 0;
		red = 8'b0;
		green = 8'b0;
		blue = 8'b0;
		sel_mod = 3'b110;
		val = 8'h64;
		addra=0;
		dina=0;
	end
	
	`define write_filename "C:\Users\manog\Vivado\2019.2\image_processor\result.coe"
	
	task writecoe;
		integer FileHandle ;
		begin
			addra = 0;
			FileHandle = $fopen(`write_filename,"wb");
		
			begin
				$fwrite(FileHandle,";	VGA Memory Map\n");
				$fwrite(FileHandle,"; .COE file with hex coefficients\n");
				$fwrite(FileHandle,"; Height : 115 ,Width:160\n");
				$fwrite(FileHandle,"memory_initialization_radix = 2\n");
				$fwrite(FileHandle,"memory_initialization_vector =\n");
			end
			
			while(addra < 15'd18400)@(posedge clk)
				begin
						if(addra==15'd18399)
							begin
								$fwrite(FileHandle,"%b;",din[addra]);
								addra = addra + 1;
							end
						else
							begin
								$fwrite(FileHandle,"%b,\n",din[addra]);
								addra = addra + 1;
							end
				end
			$fclose(FileHandle);
		end
	endtask
	
initial begin
	addra = 0;
	while(addra < 15'd18400)@(posedge clk)
		begin
			done_in = 0;
			wea = 0;
			ena = 1;
			{red,green,blue} = douta;
			done_in = 1;
			if(done_out==1)
				begin
					din[addra] = {red_o,green_o,blue_o};
					addra = addra + 1;
				end	
		end
end
	
initial begin
	#400 writecoe;
	#10 $finish;
	
end	
      
endmodule

