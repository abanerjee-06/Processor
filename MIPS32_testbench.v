`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:57:35 01/24/2020
// Design Name:   alu
// Module Name:   /home/aritra/Documents/ALU/MIPS32_testbench.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIPS32_testbench;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg [2:0] alu_control;

	// Outputs
	wire [31:0] result;
	integer i;
	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.a(a), 
		.b(b), 
		.alu_control(alu_control), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		a = 32'b1111;b = 32'b0110;alu_control = 0;i = 0;            // Two inputs a=15,b=6
		alu_control = 3'b0;
		#50;
		for (i=1;i<7;i=i+1)
		begin
			alu_control = alu_control + 3'b1;                        // All operations being checked for particular set of inputs
			#50;
		end
		a = 32'b10111;b = 32'b0100;alu_control = 0;i = 0;           // Doing the same thing as above, for another set of inputs
		alu_control = 3'b0;
		#50;
		for (i=1;i<7;i=i+1)
		begin
			alu_control = alu_control + 3'b1;
			#50;
		end
	end
   initial #700 $finish;
endmodule

