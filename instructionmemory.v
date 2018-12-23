module InstructionMemory( address , out);
	parameter delay = 5;

	input [64:0] address;

	output [31:0] out;

	reg [7:0] memory [0:511];

	reg [63:0] i;
	initial begin 
			for (i=0; i<511; i=i+1) memory[i] = 8'b0;

	end

	assign #delay out[7 : 0] = memory[address];
	assign #delay out[15 : 8] = memory[address + 1];
	assign #delay out[23 : 16] = memory[address + 2];
	assign #delay out[31 : 24] = memory[address + 3];

endmodule