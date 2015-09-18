`define dly_and 1
`define dly_or 2

module fa(a, b, ci, sum, cout);
input  a, b, ci;
output sum, cout;
xor xor0 (sum, a, b, ci);
or or0 (cout, a1, b1, b2);
and#`dly_and and1 (a1, a, b);
and and2 (b1, b, c);
and and3 (a1, c, a);
endmodule
