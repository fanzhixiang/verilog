module FIR(Dout, Din, clk, reset);

parameter b0=7;
parameter b1=17;
parameter b2=32;
parameter b3=46;
parameter b4=52;
parameter b5=46;
parameter b6=32;
parameter b7=17;
parameter b8=7;

output [17:0] Dout;
input [7:0] Din;
input clk, reset;

reg [7:0] ShiftRegister [1:8];

integer k;

assign Dout = b0*Din 
              + b1*ShiftRegister[1] 
	      + b2*ShiftRegister[2] 
	      + b3*ShiftRegister[3] 
	      + b4*ShiftRegister[4] 
	      + b5*ShiftRegister[5] 
	      + b6*ShiftRegister[6] 
	      + b7*ShiftRegister[7]
	      + b8*ShiftRegister[8];

always@(posedge clk) begin
if (reset) begin
	for(k=1; k<=8; k=k+1) ShiftRegister[k] <= 0;
end
else begin
	ShiftRegister[1] <= Din;
	for(k=2; k<=8; k=k+1) ShiftRegister[k] <= ShiftRegister[k-1];
end
end



endmodule
