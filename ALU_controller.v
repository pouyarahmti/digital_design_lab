module ALU_Control(ALU_Op, instruction, ALU_In);
	
	input [1:0] ALU_Op;
	input [31:0] instruction;
	output reg [3:0] ALU_In;
	
	wire [5:0] check_bits;
	assign check_bits = {ALU_Op ,instruction[30],instruction[29],instruction[24]};
	//Alu controller samed
	always @( check_bits ) begin	
		ALU_In = 4'bz;
			casex(check_bits)
				5'b00xxx: ALU_In = 4'b0010;
				5'bx1xxx: ALU_In = 4'b0111;
				5'b1x001: ALU_In = 4'b0010;
				5'b1x101: ALU_In = 4'b0110;
				5'b10000: ALU_In = 4'b0000;
				5'b1x010: ALU_In = 4'b0001;
			endcase
	end
endmodule 