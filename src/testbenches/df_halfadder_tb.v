`timescale 1ns / 1ns

module df_halfadder_tb;
	reg a, b;
	wire s, c;
	
	df_halfadder dut(a, b, s, c);
	
	initial begin
		$dumpfile("df_halfadder_tb.vcd");
		$dumpvars;
		
		a = 1'b0;
		b = 1'b0;
		#5;
		a = 1'b1;
		b = 1'b0;
		#5;
		a = 1'b0;
		b = 1'b1;
		#5;
		a = 1'b1;
		b = 1'b1;
		#5 $finish;
	end
endmodule
