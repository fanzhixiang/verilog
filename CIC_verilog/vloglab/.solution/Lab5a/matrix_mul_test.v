module matrix_mul_test;

parameter CYCLE = 20;

parameter a = 7;
parameter b = 13;
parameter c = 5;

wire [9:0] mo0, mo1, mo2;
reg [3:0] di0, di1, di2;
reg clk = 0;

integer cnt;

reg flag;

reg [9:0] emo0, emo1, emo2;

matrix_mul u_dut(.clk(clk), .di0(di0), .di1(di1), .di2(di2), 
		.mo0(mo0), .mo1(mo1), .mo2(mo2));

always #(CYCLE/2.0) clk = ~clk; 

always@(negedge clk) begin
	di0 <= #1 {$random}%16;
	di1 <= #1 {$random}%16;
	di2 <= #1 {$random}%16;
end

always@(posedge clk) cnt = cnt + 1;

always@(negedge clk) begin
	if (cnt != 0) begin
		if (mo0 !== emo0) begin
			flag <= 1;
			$display("ERROR !! the pattern number = %d, your MO0 is %h, but the expoected is %h, Plz correct it ~~", cnt, mo0, emo0);
			end
		if (mo1 !== emo1) begin
			flag <= 1;
			$display("ERROR !! the pattern number = %d, your MO1 is %h, but the expoected is %h, Plz correct it ~~", cnt, mo1, emo1);
			end
		if (mo2 !== emo2) begin
			flag <= 1;
			$display("ERROR !! the pattern number = %d, your MO2 is %h, but the expoected is %h, Plz correct it ~~", cnt, mo2, emo2);
			end
	
	end

end

initial begin
	#(102*CYCLE) $finish;

end

initial begin
cnt = 0;
flag = 0;
$fsdbDumpfile("MAT.fsdb");
$fsdbDumpvars;
#(101*CYCLE) begin
	$display("=====================================");
	if (flag == 0)
		$display("PASS THE TEST !!!");
	else 
		$display("FAIL, please correct all the errors !!");
	
	end
	$display("=====================================");
	
end



always@(*) begin
	emo0 = a*di0 + b*di1 + c*di2;
	emo1 = b*di0 + b*di1 + a*di2;
	emo2 = c*di0 + b*di1 + a*di2;

end



endmodule
