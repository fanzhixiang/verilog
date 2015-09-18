Xmodule mux_test;

// Signal declaration
	reg a, b, sel;

// MUX instance
	mux mux (out, a, b, sel);

// Apply Stimulus
initial
begin
	#10 a = 0; b = 0; sel = 0; // 10
	#10 a = 1; b = 0; sel = 1; //20
	#10 a = 1; b = 1; sel = 0; // 30
	#10 a = 0; b = 1; sel = 1; // 40
	#10 a = 0; b = 1; sel = 0; // 50
	#10 a = 1; b = 0; sel = 0; // 60
	#10 a = 0; b = 0; sel = 1; // 70
	#10 a = 1; b = 1; sel = 1; // 80
	#10 $finish
end


// Display Results
initial  // print all changes to all signal values
  $monitor($time, "  a = %b,  b = %b,  sel = %b,   out = %b", a,b,sel,out);



//  Waveform Record
initial
begin
     // ** Add define waveform database here **
	 $dumpfile("lab1.vcd");
	 $dumpvars;
	 $fsdbDumpfile("lab1.fsdb");
	 $fsdbDumpvars;




  // ** Add define waveform database here **
end



endmodule
