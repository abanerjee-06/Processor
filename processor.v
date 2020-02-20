`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2020 01:21:42
// Design Name: 
// Module Name: processor
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


module processor(clk,rst,branch,zero,jump,instruction,pc);

input clk,rst;

reg branch_new,zero_new,jump_new;
reg [31:0] instruction_new;
reg [29:0] pc_new;
output branch,zero,jump;
output [31:0] instruction;
output [29:0] pc;

always @(negedge clk or posedge rst) begin
if (rst) begin
assign branch_new = 1'bx;
assign zero_new = 1'bx;
assign jump_new = 1'bx;
assign pc_new = 30'b0;
end
else begin
assign branch_new = branch;
assign zero_new = zero;
assign jump_new = jump;
assign pc_new = pc;
end
end

Fetch fetch (branch_new,zero_new,jump_new,pc_new,instruction,pc);

always @(negedge clk or posedge rst) begin
if (rst) assign instruction_new = 32'bx;
else assign instruction_new = instruction;
end

execute Execute (instruction_new,branch,zero,jump,rst,clk);

initial begin
assign branch_new = 1'b0;
assign zero_new = 1'b0;
assign jump_new = 1'b0;
assign pc_new = 30'b0;
assign instruction_new = 32'bx;
end

endmodule
