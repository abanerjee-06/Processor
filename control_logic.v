`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:26 02/05/2020 
// Design Name: 
// Module Name:    control_logic 
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
module control_logic(instr,RegDst,RegWr,ExtOp,ALUSrc,ALUCtr,MemWr,MemtoReg,rs,rt,rd,imm16,branch,jump);

input [31:0] instr;
output reg RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg,branch,jump;
output reg [15:0] imm16;
output reg [4:0] rs,rt,rd;
reg [2:0] ALUop;output reg [2:0] ALUCtr;
wire [5:0] op;
reg [5:0] func;

assign op = instr[31:26];
always @(*) begin
	case (op)
	6'b000000:begin                                                  // R-type(add)
				 assign branch = 1'b0;assign jump = 1'b0;assign RegDst = 1'b1;
				 assign RegWr = 1'b1;assign ExtOp = 1'bx;assign ALUSrc = 1'b0;
				 assign ALUop = 3'b100;assign MemtoReg = 1'b0;
				 assign MemWr = 1'b0;assign func = instr[5:0];
				 assign rd = instr[15:11];assign rt = instr[20:16];
				 assign rs = instr[25:21];assign imm16 = 16'bx;
				 end
	6'b001101:begin                                                  // ori
				assign branch = 1'b0;assign jump = 1'b0;assign RegDst = 1'b0;
				assign RegWr = 1'b1;assign ExtOp = 1'b0;assign ALUSrc = 1'b1;
				assign ALUCtr = 3'b011;assign MemtoReg = 1'b0;
				assign MemWr = 1'b0;assign func = 6'bx;
				assign rs = instr[25:21];assign rt = instr[20:16];
				assign imm16 = instr[15:0];assign rd = 5'b0;
				end
	6'b100011:begin                                                 // lw
				 assign branch = 1'b0;assign jump = 1'b0;assign RegDst = 1'b0;
				 assign RegWr = 1'b1;assign ExtOp = 1'b1;assign ALUSrc = 1'b1;
				 assign ALUCtr = 3'b000;assign MemtoReg = 1'b1;
				 assign MemWr = 1'b0;assign func = 6'bx;
				 assign rs = instr[25:21];assign rt = instr[20:16];
				 assign imm16 = instr[15:0];assign rd = 5'b0;
				 end
	6'b101011:begin																 // sw
				 assign branch = 1'b0;assign jump = 1'b0;assign RegDst = 1'bx;
				 assign RegWr = 1'b0;assign ExtOp = 1'b1;assign ALUSrc = 1'b1;
				 assign ALUCtr = 3'b000;assign MemtoReg = 1'bx;
				 assign MemWr = 1'b1;assign func = 6'bx;		
				 assign rs = instr[25:21];assign rt = instr[20:16];
				 assign rd = 5'b0;assign imm16 = instr[15:0];
				 end
	6'b000100:begin																 // beq
				 assign branch = 1'b1;assign jump = 1'b0;assign RegDst = 1'bx;
				 assign RegWr = 1'b0;assign ExtOp = 1'bx;assign ALUSrc = 1'b0;
				 assign ALUCtr = 3'b001;assign MemtoReg = 1'bx;
				 assign MemWr = 1'b0;assign func = 6'bx;
				 assign rs = instr[25:21];assign rt = instr[20:16];
				 assign imm16 = instr[15:0];assign rd = 5'b0;
				 end
	6'b000010:begin																 // jump
				 assign branch = 1'b0;assign jump = 1'b1;assign RegDst = 1'bx;
				 assign RegWr = 1'b0;assign ExtOp = 1'bx;assign ALUSrc = 1'bx;
				 assign ALUCtr = 3'bxxx;assign MemtoReg = 1'bx;
				 assign MemWr = 1'b0;assign func = 6'bx;
				 assign rs = 5'b0;assign rt = 5'b0;assign rd = 5'b0;
				 assign imm16 = 16'bx;
				 end
	endcase	                                                
	case (func)
	6'b100000: assign ALUCtr = 3'b000;
	6'b100010: assign ALUCtr = 3'b001;
	6'b100100: assign ALUCtr = 3'b010;
	6'b100101: assign ALUCtr = 3'b011;
	6'b100110: assign ALUCtr = 3'b100;
	6'b000000: assign ALUCtr = 3'b101;
	6'b000010: assign ALUCtr = 3'b110;
	endcase
end

endmodule 