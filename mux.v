module mux( out  , address , in1 , in2 ,);
	parameter n = 64;
	parameter delay = 5;
	input [n-1:0] in1;
	input [n-1:0] in2;
	input address;

	//using reg for changing the data in the always
	output [n-1:0] out;

	assign #delay out = (address == 0 ) ? in1 : in2; 
endmodule 