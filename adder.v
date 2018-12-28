module adder(in1,in2,  out);
	parameter delay = 5;
	input [63:0] in2;
	input [63:0] in1;
	output[63:0] out;  
	//checked
	assign out = in1 + in2;
endmodule