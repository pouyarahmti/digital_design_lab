module memory(d_out , clock, address, d_in, read, write );
	output [63:0] d_out;
	input clock;
	input [63:0] address;
	input [63:0] d_in;
	input read;
	input write;

	reg [63:0] memory [512:0];
	
	
		
	assign d_out = read == 1 ? memory[address] : 0;
	
	always @(posedge clock) begin
		if(write == 1) begin
			memory[address] <= d_in;
		end
	end 
endmodule