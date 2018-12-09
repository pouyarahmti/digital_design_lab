module adder(in,in2  out);
	input [63:0] in ;
	output[63:0] out;  

	assign out = in + in2;
endmodule