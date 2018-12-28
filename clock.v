module clock(clk);
	output reg clk = 1;
	
	always #100 clk = ~clk;
endmodule