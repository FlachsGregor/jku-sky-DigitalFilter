`timescale 1ns / 1ns

module df_adder_noovfl_tb;
	
	reg [8:0] a;
	reg [8:0] b;
	wire [7:0] out;
	
	df_adder_noovfl dut(a, b, out);
	
	initial begin
		$dumpfile("df_adder_noovfl_tb.vcd");
		$dumpvars;
		
		a = 9'd0;
		b = 9'd0;
		#5;
		
		a = 9'd47;
		b = 9'd837;
		#5;
		
		a = 9'd28;
		b = 9'd139;
		#5;
		
		a = 9'd247;
		b = 9'd503;
		#5;
		
		a = 9'd432;
		b = 9'd916;
		#5;
		
		a = 9'd52;
		b = 9'd297;
		#5;
		
		a = 9'd255;
		b = 9'd255;
		#5;
		
		a = 9'd256;
		b = 9'd256;
		#5 $finish;
	end
endmodule
