`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:29:39 02/02/2020 
// Design Name: 
// Module Name:    regfile 
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
module regfile(ReadRegister1,ReadRegister2,WriteRegister,WriteData,RegWrite,reset,clk,ReadData1,ReadData2);

input reset,clk,RegWrite;
input [4:0] ReadRegister1,ReadRegister2,WriteRegister;
input [31:0] WriteData; 
output [31:0] ReadData1,ReadData2;
reg [31:0] RegArray [0:31];

always @(negedge clk or posedge reset) begin
if (reset) begin
RegArray[0] <= 32'b0;RegArray[1] <= 32'b0;
RegArray[2] <= 32'b0;RegArray[3] <= 32'b0;
RegArray[4] <= 32'b0;RegArray[5] <= 32'b0;
RegArray[6] <= 32'b0;RegArray[7] <= 32'b0;
RegArray[8] <= 32'b0;RegArray[9] <= 32'b0;
RegArray[10] <= 32'b0;RegArray[11] <= 32'b0;
RegArray[12] <= 32'b0;RegArray[13] <= 32'b0;
RegArray[14] <= 32'b0;RegArray[15] <= 32'b0;
RegArray[16] <= 32'b0;RegArray[17] <= 32'b0;
RegArray[18] <= 32'b0;RegArray[19] <= 32'b0;
RegArray[20] <= 32'b0;RegArray[21] <= 32'b0;
RegArray[22] <= 32'b0;RegArray[23] <= 32'b0;
RegArray[24] <= 32'b0;RegArray[25] <= 32'b0;
RegArray[26] <= 32'b0;RegArray[27] <= 32'b0;
RegArray[28] <= 32'b0;RegArray[29] <= 32'b0;
RegArray[30] <= 32'b0;RegArray[31] <= 32'b0;
end
else begin
if (RegWrite) RegArray[WriteRegister] <= WriteData;
else RegArray[WriteRegister] <= ~(~(RegArray[WriteRegister]));
end
end
assign ReadData1 = (ReadRegister1 == 0) ? 16'b0 : RegArray[ReadRegister1];
assign ReadData2 = (ReadRegister2 == 0) ? 16'b0 : RegArray[ReadRegister2];

initial begin
	RegArray[0] = 32'b0;RegArray[1] = 32'd0;
	RegArray[2] = 32'd0;RegArray[3] = 32'd3;
	RegArray[4] = 32'd12;RegArray[5] = 32'd0;
	RegArray[6] = 32'd0;RegArray[7] = 32'd0;
	RegArray[8] = 32'd165;RegArray[9] = 32'd0;
	RegArray[10] = 32'd0;RegArray[11] = 32'd0;
	RegArray[12] = 32'd0;RegArray[13] = 32'd0;
	RegArray[14] = 32'd0;RegArray[15] = 32'd0;
	RegArray[16] = 32'd0;RegArray[17] = 32'd0;
	RegArray[18] = 32'd0;RegArray[19] = 32'd0;
	RegArray[20] = 32'd0;RegArray[21] = 32'd0;
	RegArray[22] = 32'd0;RegArray[23] = 32'd0;
	RegArray[24] = 32'd0;RegArray[25] = 32'd0;
	RegArray[26] = 32'd0;RegArray[27] = 32'd0;
	RegArray[28] = 32'd0;RegArray[29] = 32'd0;
	RegArray[30] = 32'd0;RegArray[31] = 32'd0;
end

endmodule  
