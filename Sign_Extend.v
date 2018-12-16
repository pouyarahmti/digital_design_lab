module signextend(in, out);
	input [31:0] in;
	output [63:0] out;
	assign out = {{32{in[31]}}, in};
endmodule