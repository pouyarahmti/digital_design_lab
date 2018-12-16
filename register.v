
module register(old_pc ,clock , new_pc, write, reset);
	input clock;
	input write;
	input [63:0] new_pc;
	input reset;
	output  [63:0] old_pc;

	assign old_pc = ( reset == 1 ) ? 0  : new_pc ;
endmodule