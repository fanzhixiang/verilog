`define cycle 10
module fsm_mealy_test;

reg reset;
reg ans;
reg xin;
reg en;
integer cnt;
parameter A0=2'b00, A1 = 2'b01, A2=2'b10, A3=2'b11;

reg clk;
initial clk = 0;
always #(`cycle/2) clk=~clk;


fsm_mealy dut(.clk(clk), .reset(reset), .en(en), .xin(xin), .zout(zout));


initial begin
reset = 1;
en = 1;
xin=0;
ans=0;

@(posedge clk) begin #1
reset = 0;
xin=0;
ans=0;
end

@(posedge clk) begin #1
reset = 0;
xin=1;
ans=0;
end

@(posedge clk) begin #1
reset = 0;
xin=0;
ans=1;
end

@(posedge clk) begin #1
reset = 0;
xin=1;
ans=1;
end
//--------------------------------
@(posedge clk) begin #1
reset = 0;
xin=1;
ans=0;
end

@(posedge clk) begin #1
reset = 0;
xin=1;
ans=1;
end

@(posedge clk) begin #1
reset = 0;
xin=0;
ans=1;
end

@(posedge clk) begin #1
reset = 0;
xin=0;
ans=0;
end
//--------------------------------
@(posedge clk) begin #1
reset = 0;
xin=1;
ans=0;
end

@(posedge clk) begin #1
reset = 0;
xin=0;
ans=0;
end

@(posedge clk) begin #1
reset = 0;
xin=0;
ans=1;
end
//------------------------------
#5 en = 0;
ans=0;
#10 en=1;
ans=1;

@(posedge clk) begin #1
reset = 0;
xin=0;
ans=0;
end

#5 reset=1;
ans=0;

#10 reset=0;

$display($time, ,"finish testing without error!!");
$finish;
end

always@(posedge clk) begin
if (reset) cnt = 0;
else cnt = cnt+1;
#1 $display($time,,"reset=%b, en=%b, xin=%b, zout=%b", reset, en, xin, zout);
#1 if((zout != ans)|(zout===1'bz)|(zout===1'bx)) begin
	$display($time,,"Testing failed at cycle %d, the zout should be %b", cnt, ans);
	$finish;
	end 

end







initial begin
$fsdbDumpfile("fsm_mealy.fsdb");
$fsdbDumpvars;
end


endmodule
