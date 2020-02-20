`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2020 23:56:37
// Design Name: 
// Module Name: processor_test
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
module processor_test;

reg clk;
reg rst;

wire [31:0] instruction;
wire [29:0] pc;
wire branch;
wire zero;
wire jump;

processor uut(
.clk(clk),
.rst(rst),
.instruction(instruction),
.pc(pc),
.branch(branch),
.zero(zero),
.jump(jump)
);

always @(*)
begin
clk=~clk;
end


initial begin
rst = 0;clk = 1;
#100 $finish;
end

endmodule
