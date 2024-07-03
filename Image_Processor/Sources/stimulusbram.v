`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:17:56 06/15/2020
// Design Name:   image
// Project Name:  Image_Processing
// Target Device:  
// Tool versions:  
// Description: 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stimulusbram;

	// Inputs
	reg clka;
	reg rsta;
	reg ena;
	reg [0:0] wea;
	reg [14:0] addra;
	reg [23:0] dina;

	// Outputs
	wire [23:0] douta;

	// Instantiate the Unit Under Test (UUT)
	image uut (
		.clka(clka), 
		.rsta(rsta), 
		.ena(ena), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		clka = 0;
	end
	
	always begin 
		#0.01 clka = !clka;
	end
	
	initial begin
		// Initialize Inputs
		rsta = 0;
		ena = 0;
		wea = 0;
		addra = 0;
		dina = 0;
		// Wait 100 ns for global reset to finish
    end    
		// Add stimulus here
		always @(posedge clka)
			begin
				wea=0;
				ena=1;
				if(addra < 15'd18400)
					begin
						$display("data at addr %d is %b",addra,douta);
						addra = addra + 1;
					end
				else
					begin
						addra = 0;
						wea=0;
						ena=1;
						if(addra < 15'd18400)
							begin
								$display("data at addr %d is %b",addra,douta);
								addra = addra + 1;
							end
						else
							$finish;
					end
			end
      
endmodule

