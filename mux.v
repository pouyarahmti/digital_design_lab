module mux( out  , address , in1 , in2 ,);
	parameter n = 64;
	input [n-1:0] in1;
	input [n-1:0] in2;
	input address;
	output [n-1:0] out;

	assign out = (address == 0) ? (in1) : (in2) ;

endmodule 