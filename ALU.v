`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:10:16 01/13/2020 
// Design Name: 
// Module Name:    MIPS32 
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
module alu(input [31:0]a,input [31:0]b,input [2:0]alu_control, output reg [31:0] result);
	always@(*)                                              // ALU block for processor
	begin
		case (alu_control)                                   // control signal for determining operation of ALU
		3'b000: result = a + b; 
		3'b001: result = a - b;
		3'b010: result = a & b;
		3'b011: result = a | b;                              // Operations included are ADD,SUB,AND,OR,XOR,SHIFT_LEFT,SHIFT_RIGHT
		3'b100: result = a ^ b;
		3'b101: result = a << b;
		3'b110: result = a >> b;
		endcase
	end
endmodule 