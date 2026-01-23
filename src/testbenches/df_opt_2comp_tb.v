`timescale 1ns / 1ns

module df_opt_2comp_tb;
	
	integer i;
	
	reg [7:0] data;
	reg en = 0;
	wire [8:0] out;
	
	df_opt_2comp dut(data, en, out);
	
	initial begin
		$dumpfile("df_opt_2comp_tb.vcd");
		$dumpvars;
		
		data = 8'd0;
		en = 1'b0;
		#5;
		en = 1'b1;
		#5;
		
		data = 8'd23;
		en = 1'b0;
		#5;
		en = 1'b1;
		#5;
		
		data = 8'd247;
		en = 1'b0;
		#5;
		en = 1'b1;
		#5;
		
		data = 8'd185;
		en = 1'b0;
		#5;
		en = 1'b1;
		#5;
		
		data = 8'd86;
		en = 1'b0;
		#5;
		en = 1'b1;
		#5;
		
		data = 8'd255;
		en = 1'b0;
		#5;
		en = 1'b1;
		#5;
		
		data = 8'd149;
		en = 1'b0;
		#5;
		en = 1'b1;
		#5 $finish;
	end
endmodule
