module InstructionMemory( address , out);
	parameter delay = 10;

	input [64:0] address;

	output [31:0] out;

	reg [7:0] memory [0:511];

	reg [63:0] i;

	initial begin 
		for (i=0; i<511; i=i+1) memory[i] = 8'b0;
				
		{memory[0 + 3], memory[0 + 2], memory[0 + 1], memory[0 + 0]} = 32'h8b1f03e5;
		{memory[4 + 3], memory[4 + 2], memory[4 + 1], memory[4 + 0]} = 32'hf84000a4;
		{memory[8 + 3], memory[8 + 2], memory[8 + 1], memory[8 + 0]} = 32'h8b040086;
		{memory[12 + 3], memory[12 + 2], memory[12 + 1], memory[12 + 0]} = 32'hf80010a6;
	end

	assign #delay out = {
		memory[address + 3],
		memory[address + 2],
		memory[address + 1],
		memory[address + 0]
	};

endmodule