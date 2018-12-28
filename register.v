
module register(old_pc ,clock , new_pc, reset);
	parameter n = 64;
	input clock;
	input [n-1:0] new_pc;
	input reset;
	output reg  [n-1:0] old_pc;

	always @(posedge clock) begin

		if(reset == 1'b1 ) begin
			old_pc <= 0;
		end
		else begin
			old_pc <= new_pc;
		end
		
	end
endmodule