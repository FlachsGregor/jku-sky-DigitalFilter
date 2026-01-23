`timescale 1ns / 1ns

module df_adder_subtractor_tb;
	
	reg [8:0] a;
	reg [8:0] b;
	reg sub;
	wire [8:0] out;
	
	df_adder_subtractor dut(a, b, sub, out);
	
	initial begin
		$dumpfile("df_adder_subtractor_tb.vcd");
		$dumpvars;
		
		a = 9'd0;
		b = 9'd0;
		sub = 1'b0;
		#5;
		sub = 1'b1;
		#5;
		
		a = 9'd72;
		b = 9'd0;
		sub = 1'b0;
		#5;
		sub = 1'b1;
		#5;
		
		a = 9'd0;
		b = 9'd163;
		sub = 1'b0;
		#5;
		sub = 1'b1;
		#5;
		
		a = 9'd179;
		b = 9'd58;
		sub = 1'b0;
		#5;
		sub = 1'b1;
		#5;
		
		a = 9'd46;
		b = 9'd137;
		sub = 1'b0;
		#5;
		sub = 1'b1;
		#5;
		
		a = 9'd127;
		b = 9'd127;
		sub = 1'b0;
		#5;
		sub = 1'b1;
		#5 $finish;
	end
endmodule
