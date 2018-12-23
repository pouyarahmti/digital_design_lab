module ALU_Control(ALU_Op, Op_Code, ALU_In);
	
	input [1:0] ALU_Op;
	input [10:0] Op_Code;
	output reg [3:0] ALU_In;
	always @(ALU_Op, Op_Code) begin
		 case(ALU_Op) 
		     2'b00: ALU_In = 4'b0010;
		     2'b01: ALU_In = 4'b0111;
		     2'b10:
			casex(Op_Code)
				11'b11xxxxxxxxx: ALU_In = 4'b0110;
				11'b101xxxxxxxx: ALU_In = 4'b0001;
				11'b10001010xxx: ALU_In = 4'b0000;
				11'b10001011xxx: ALU_In = 4'b0010;
			endcase
		  endcase
	end
endmodule 