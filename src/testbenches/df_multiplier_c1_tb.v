// License

`timescale 1ns / 1ns

module df_multiplier_c1_tb;
	
	integer i;	
	
	reg [1:0] coef;
	reg [7:0] data;
	wire [7:0] out;
	
	wire [7:0] c;
	wire [15:0] mul;
	
	df_multiplier_c1 df_multiplier_c1_dut(coef, data, out);
	
	assign c = {coef, 6'b100000};
	
	assign mul = data * c;
	
	initial begin
		$dumpfile("df_multiplier_c1_tb.vcd");
		$dumpvars;
		for (i = 0; i <= 2; i = i + 1) begin
			$dumpvars(0, df_multiplier_c1_dut.stage1[i]);
		end
		for (i = 0; i <= 1; i = i + 1) begin
			$dumpvars(0, df_multiplier_c1_dut.stage2[i]);
		end
		
		data = 8'hff;
		
		for (i = 0; i <= 3; i = i + 1) begin
			coef = i;
			#5;
		end
		#5 $finish;
		
		//coef = 2'b00;
		//data = 8'hff;
		//#5;
		//coef = 2'b01;
		//#5;
		//coef = 2'b10;
		//#5;
		//coef = 2'b11;
		//#5 $finish;
	end
endmodule
