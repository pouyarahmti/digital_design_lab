module ALU(num1, num2, op, z, out );
	input [63:0] num1;
	input [63:0] num2;
	input [3:0] op;
	output reg z;
	output reg [63:0] out;
	always @(num1 , num2 , op) begin 
	
		case(op)
			4'b0000:out = num1&num2;
			4'b0001:out = num1|num2;
			4'b0010:out = num1+num2;
			4'b0110:out = num1-num2;
			4'b0111:out = num2;
			4'b1100:out = ~(num1|num2);
		endcase
		if( out == 0 )begin
			z = 1 ;
		end
		else if( out != 0 ) begin
			z = 0;
		end
	end 
 endmodule