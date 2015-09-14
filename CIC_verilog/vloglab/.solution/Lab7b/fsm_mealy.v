module fsm_mealy(clk, reset, en, xin, zout);
input clk, reset, en, xin;
output zout;

reg zout;
reg [1:0] C_STATE, N_STATE;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always@(posedge clk)   // CS
begin
if (reset) C_STATE <= S0;
else if (en) C_STATE <= N_STATE;
end

always@(C_STATE or xin)  // NS
begin
case ( C_STATE )
	S0 : N_STATE = (!xin) ? S1 : S0; 
	S1 : N_STATE = (!xin) ? S0 : S3;
	S2 : N_STATE = (!xin) ? S0 : S1;
	S3 : N_STATE = (!xin) ? S2 : S3;  
	default : N_STATE = S0;
endcase
end


always@(C_STATE or xin or en)  // Separate OL
begin
if ( en ) begin
case ( C_STATE )
	S0 : zout = (!xin) ? 0 : 0; 
	S1 : zout = (!xin) ? 1 : 0;
	S2 : zout = (!xin) ? 0 : 1;
	S3 : zout = (!xin) ? 1 : 1;  
	default : zout = 0;
endcase
end
else	zout = 0;
end


endmodule

