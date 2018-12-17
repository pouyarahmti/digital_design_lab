module registerbank(clk , write , address1  , address2 , address3 , input_data , output_data1 , output_data2 );

	input clk ;
	input write;
	input [4:0] address1 , address2 , address3; 	
	input [63:0] input_data;
	output [63:0] output_data1 , output_data2 ;

	reg [63:0] registers [0:31];

	assign output_data1 = registers[address1];
	assign output_data2 = registers[address2];

	always @ (posedge clk) begin 
		if(write)	begin
			registers[address3] = input_data;
		end 
	end
endmodule