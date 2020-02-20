`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:23 02/02/2020 
// Design Name: 
// Module Name:    execute 
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
module Mux(a,b,sel,o); 

input sel;
input [31:0] a,b;
output [31:0] o;

assign o = (sel == 0) ? a : b; 

endmodule

module Data_Memory(Addr,DataIn,WrEn,DataOut,clk);

input WrEn,clk;
input [31:0] Addr,DataIn;
output [31:0] DataOut;

reg [31:0] datamem[31:0];

always @(negedge clk)
begin
	if (WrEn) datamem[Addr] = DataIn; 
	else datamem[Addr] = ~(~(datamem[Addr]));
end

initial begin
	datamem[0] = 32'b0;datamem[1] = 32'd0;
	datamem[2] = 32'd0;datamem[3] = 32'd14;
	datamem[4] = 32'd35;datamem[5] = 32'd0;
	datamem[6] = 32'd0;datamem[7] = 32'd0;
	datamem[8] = 32'd144;datamem[9] = 32'd0;
	datamem[10] = 32'd0;datamem[11] = 32'd0;
	datamem[12] = 32'd0;datamem[13] = 32'd0;
	datamem[14] = 32'd0;datamem[15] = 32'd0;
	datamem[16] = 32'd0;datamem[17] = 32'd0;
	datamem[18] = 32'd0;datamem[19] = 32'd0;
	datamem[20] = 32'd0;datamem[21] = 32'd0;
	datamem[22] = 32'd0;datamem[23] = 32'd0;
	datamem[24] = 32'd0;datamem[25] = 32'd0;
	datamem[26] = 32'd0;datamem[27] = 32'd0;
	datamem[28] = 32'd0;datamem[29] = 32'd0;
	datamem[30] = 32'd0;datamem[31] = 32'd0;
end

assign DataOut = ~(~(datamem[Addr]));
	
endmodule

module execute(instr,branch,zero,jump,reset,clk);

input reset,clk;
input [31:0] instr;
output branch,zero,jump;
wire RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg;
wire [2:0] ALUCtr;
wire [31:0] Extension;
wire [31:0] W,W1,W2,Ans,A,B;
wire [15:0] imm16;
wire [4:0] rs,rt,rd,rw;

control_logic CONTROL(instr,RegDst,RegWr,ExtOp,ALUSrc,ALUCtr,MemWr,MemtoReg,
							 rs,rt,rd,imm16,branch,jump); 
assign Extension = (ExtOp == 1'b0) ? {16'b0,imm16} : {{16{imm16[15]}},imm16};
//always @(*) begin 
//	case(ExtOp)
//	1'b1: assign Extension = {{16{imm16[15]}},imm16};
//	1'b0: assign Extension = {16'b0,imm16};
//	1'bx: assign Extension = {16'bx,imm16};
//	endcase
//end

Mux mux1(rt,rd,RegDst,rw);
Mux mux2(B,Extension,ALUSrc,W1);
regfile REGISTER(rs,rt,rw,W,RegWr,reset,clk,A,B);
alu ALU(A,W1,ALUCtr,Ans);                            //add,sub,and,or,xor,shiftleft,shiftright can be implemented
Data_Memory data_mem(Ans,B,MemWr,W2,clk);
Mux mux3(Ans,W2,MemtoReg,W);

assign zero = (ALUCtr == 3'b001 && Ans == 32'b0) ? 1 : 0;

endmodule
 