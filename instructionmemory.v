module InstructionMemory( address , out);

	input [4:0] address;

	output [63:0] out;

	reg [63:0] memory [0:31];
	
	assign	out = memory[address];

endmodule