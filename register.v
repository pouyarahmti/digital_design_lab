module register(old_pc ,clock , new_pc, write, reset);
	input clock;
	input write;
	input [63:0] new_pc;
	input reset;
	output reg [63:0] old_pc;

	initial begin 
	old_pc = 0;
	
	end
	
	always @(posedge clock) begin
		if(write == 1)begin
			old_pc <= new_pc;
		end
		if(reset == 1)begin
			old_pc <= 0;			
		end
	end
endmodule