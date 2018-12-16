module signextend(in, out);

	//should be changed for including evey type of instruction immediate
	input [31:0] in;
	output [63:0] out;
	assign out = {{32{in[31]}}, in};
endmodule