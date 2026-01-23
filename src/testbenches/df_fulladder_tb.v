`timescale 1ns / 1ns

module df_fulladder_tb;
	reg a, b, ci;
	wire s, co;
	
	df_fulladder dut(a, b, ci, s, co);
	
	initial begin
		$dumpfile("df_fulladder_tb.vcd");
		$dumpvars;
		
		a = 1'b0;
		b = 1'b0;
		ci = 1'b0;
		#5;
		a = 1'b1;
		b = 1'b0;
		ci = 1'b0;
		#5;
		a = 1'b0;
		b = 1'b1;
		ci = 1'b0;
		#5;
		a = 1'b1;
		b = 1'b1;
		ci = 1'b0;
		#5;
		a = 1'b0;
		b = 1'b0;
		ci = 1'b1;
		#5;
		a = 1'b1;
		b = 1'b0;
		ci = 1'b1;
		#5;
		a = 1'b0;
		b = 1'b1;
		ci = 1'b1;
		#5;
		a = 1'b1;
		b = 1'b1;
		ci = 1'b1;
		#5 $finish;
	end
endmodule
