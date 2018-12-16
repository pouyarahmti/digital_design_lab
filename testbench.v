module testbench ();

	wire [63:0] d_out;
	wire [63:0] pc;
	wire [63:0] next_pc;
	
clock clock1(clk);
register register1(pc, clk, next_pc, 1, 0);
adder adder1(pc, next_pc);
memory memory1(d_out, clk, pc, pc , 0 , 1);

endmodule