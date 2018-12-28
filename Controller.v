module Controller(Instruction, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
	input [10:0] Instruction;
	output reg Reg2Loc;
	output reg ALUSrc;
	output reg MemtoReg;
	output reg RegWrite;
	output reg MemRead;
	output reg MemWrite;
	output reg Branch;
	output reg ALUOp1;
	output reg ALUOp0;
	
	// ALUops are different
	
	//not exacly samed
	
	always @(Instruction) begin
		casex(Instruction)
			11'b00000000000:
				begin
				 	Reg2Loc = 1'b0; 
					ALUSrc = 1'b0; 
					MemtoReg = 1'b0; 
					RegWrite = 1'b0;
					MemRead = 1'b0; 
					MemWrite = 1'b0; 
					Branch = 1'b0; 
					ALUOp1 = 1'b0; 
					ALUOp0 = 1'b0;
				end
			11'b1xx0101x000:
				begin
				 	Reg2Loc = 1'b0; 
					ALUSrc = 1'b0; 
					MemtoReg = 1'b0; 
					RegWrite = 1'b1;
					MemRead = 1'b0; 
					MemWrite = 1'b0; 
					Branch = 1'b0; 
					ALUOp1 = 1'b1; 
					ALUOp0 = 1'b0;
				end
		 	11'b11111000010:
				begin
				 	Reg2Loc = 1'b0; 
					ALUSrc = 1'b1; 
					MemtoReg = 1'b1; 
					RegWrite = 1'b1;
					MemRead = 1'b1; 
					MemWrite = 1'b0; 
					Branch = 1'b0; 
					ALUOp1 = 1'b0; 
					ALUOp0 = 1'b0;
				end
		 	11'b11111000000:
				begin
				 	Reg2Loc = 1'b1; 
					ALUSrc = 1'b1; 
					MemtoReg = 1'b0; 
					RegWrite = 1'b0;
					MemRead = 1'b0; 
					MemWrite = 1'b1; 
					Branch = 1'b0; 
					ALUOp1 = 1'b0; 
					ALUOp0 = 1'b0;
				end
			11'b10110100xxx:
				begin
				 	Reg2Loc = 1'b1; 
					ALUSrc = 1'b0; 
					MemtoReg = 1'b0; 
					RegWrite = 1'b0;
					MemRead = 1'b0; 
					MemWrite = 1'b0; 
					Branch = 1'b1; 
					ALUOp1 = 1'b0; 
					ALUOp0 = 1'b1;
				end
			default:
				begin
				 	Reg2Loc = 1'bz; 
					ALUSrc = 1'bz; 
					MemtoReg = 1'bz; 
					RegWrite = 1'bz;
					MemRead = 1'bz; 
					MemWrite = 1'bz; 
					Branch = 1'bz; 
					ALUOp1 = 1'bz; 
					ALUOp0 = 1'bz;
				end
		endcase
	end
endmodule
