module InstructionMemory( address , out);
	parameter delay = 10;

	input [63:0] address;

	output [31:0] out;

	reg [7:0] memory [0:31];



	initial begin 	
		{memory[3], memory[2], memory[1], memory[0]} = 32'h8b1f03e5;
		{memory[7], memory[6], memory[5], memory[4]} = 32'hf84000a4;
		{memory[11], memory[10], memory[9], memory[8]} = 32'h8b040086;
		{memory[15], memory[14], memory[13], memory[12]} = 32'hf80010a6;
	end

	assign  out  = {memory[address + 3],memory[address + 2],memory[address + 1],memory[address + 0] };
	

endmodule