module ALU(num1, num2, op, z, out );
	input [63:0] num1;
	input [63:0] num2;
	input [3:0] op;
	output  z;
	output reg [63:0] out;

	assign z = (out) ? 0 : 1 ; 

	always @(num1 , num2 , op) begin 
		out = 64'hz;	
		case(op)	
			4'b0000:out = num1&num2;
			4'b0001:out = num1|num2;
			4'b0010:out = num1+num2;
			4'b0110:out = num1-num2;
			4'b0111:out = num2;
			4'b1100:out = ~(num1|num2);
		endcase
	end 
 endmodule