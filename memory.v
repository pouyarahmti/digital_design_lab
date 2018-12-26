module memory(d_out , clock, address, d_in, read, write );
	parameter size = 256;
	output [63:0] d_out;
	input clock;
	input [63:0] address;
	input [63:0] d_in;
	input read;
	input write;

	reg [63:0] memory [0:size - 1];
	
	assign output_data = read == 1 ? {memory[address + 7],
			memory[address + 6],
			memory[address + 5],
			memory[address + 4],
			memory[address + 3],
			memory[address + 2],
			memory[address + 1],
			memory[address + 0]} : 63'bz;
	
		
	always @(posedge clock) begin
		if(write == 1) begin
			memory[address + 7] = d_in[63:56];
			memory[address + 6] = d_in[55:48];
			memory[address + 5] = d_in[47:40];
			memory[address + 4] = d_in[39:32];
			memory[address + 3] = d_in[31:24];
			memory[address + 2] = d_in[23:16];
			memory[address + 1] = d_in[15:8];
			memory[address + 0] = d_in[7:0];
		end
	end 


endmodule