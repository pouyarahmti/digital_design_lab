
module register(old_pc ,clock , new_pc, reset);
	input clock;
	input [63:0] new_pc;
	input reset;
	output reg  [63:0] old_pc;

	always @(posedge clock) begin

		if(reset == 1'b1 ) begin
			old_pc <= 64'b0;
		end
		else begin
			old_pc <= new_pc;
		end
		
	end
endmodule