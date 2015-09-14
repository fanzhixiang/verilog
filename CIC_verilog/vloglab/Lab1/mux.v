
`define dly_and 1
`define dly_or 2

module mux (out, a, b, sel);
input [0:0] a, b, sel;
output out;
wire [0:0] a, b, sel, sel_;
wire [0:0] out, a0, b0;
not    not1(sel_, sel);
and#`dly_and    and1(a0, a[0], sel_[0]);
and#`dly_and    and2(b0, b[0], sel[0]);
or#`dly_or      or1(out, a0, b0);


endmodule
