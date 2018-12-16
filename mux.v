module mux( out  , address , in1 , in2 ,);
	parameter n = 64;
	parameter delay = 5;
	input [n-1:0] in1;
	input [n-1:0] in2;
	input address;

	//using reg for changing the data in the always
	output reg [n-1:0] out;

	always begin 
		#delay
		if(address == 0) begin
			out <= in1;
		end
		else if (address == 1) begin 
			out <= in2;
		end 
	end
endmodule 