`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2020 03:22:59
// Design Name: 
// Module Name: Fetch
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
module InstructionMemory(addr,instr);

input [31:0]addr;
output [31:0] instr;
reg [31:0] instr_mem [31:0];
reg [31:0] temp;

always @(addr) begin
temp = instr_mem[addr/4];
end
assign instr = ~(~temp);

initial begin
instr_mem[0] = 32'b00000000100000110010100000100000 ;
instr_mem[1] = 32'b00110100011001100000000000000100;
instr_mem[2] = 32'b10101100011001010000000000000100;
instr_mem[3] = 32'b00000000100001100010100000100010;
instr_mem[4] = 32'b10001100011001100000000000000100;
end 

endmodule   

module Fetch(branch,zero,jump,pc,instr,pc_new);

input branch,zero,jump;
input [29:0] pc;
output [31:0] instr;
output [29:0] pc_new;

wire [31:0] addr;
wire [29:0]w2,w3,w4,w6,w7,w8;
wire w5;

assign addr[31:2] = pc;
assign addr[1:0] = 2'b0;

InstructionMemory instr_mem (addr,instr);

assign w2 = pc + 30'b1;
assign pc_new = pc + 30'b1;
assign w4 = {{14{instr[15]}},instr[15:0]};
assign w3 = w2 + w4;
assign w5 = branch && zero;
assign w6 = (w5 == 1'b1) ? w3 : w2;
assign w7[29:26]=pc[31:28];
assign w7[25:0] = instr[25:0];
//assign w7[1:0] = 2'b0;
assign w8 = (jump == 1'b1) ? w7 : w6;

endmodule
