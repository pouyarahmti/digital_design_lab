module shift_2bit(in, out);
	parameter delay = 5;
	input [63:0] in;
	output [63:0] out;
	//just delay is different
	assign  out = in << 2;

endmodule