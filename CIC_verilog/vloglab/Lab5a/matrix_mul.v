module matrix_mul(
	input clk, 
	input [3:0] di0, 
	input [3:0] di1, 
	input [3:0] di2, 
	output reg [9:0] mo0, 
	output reg [9:0] mo1, 
	output reg [9:0] mo2);
	
parameter a = 7;
parameter b = 13;
parameter c = 5;

	/*reg [9:0] mo0; 
	reg [9:0] mo1; 
	reg [9:0] mo2;*/

always@(posedge clk) begin
	mo0 = a*di0 + b*di1 + c*di2;
	mo1 = b*di0 + b*di1 + a*di2;
	mo2 = c*di0 + b*di1 + a*di2;
end






	
	
endmodule
