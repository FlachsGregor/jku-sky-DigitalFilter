`timescale 1ns / 1ns

module df_multiplier_c4_tb;
	
	integer i;
	
	reg [4:0] coef;
	reg [7:0] data;
	wire [7:0] out;
	
	wire [7:0] c;
	wire [15:0] mul;
	
	df_multiplier_c4 dut(coef, data, out);
	
	assign c = {3'b0, coef};
	
	assign mul = data * c;
	
	initial begin
		$dumpfile("df_multiplier_c4_tb.vcd");
		$dumpvars;
		for (i = 0; i <= 4; i = i + 1) begin
			$dumpvars(0, dut.stage1[i]);
		end
		for (i = 0; i <= 3; i = i + 1) begin
			$dumpvars(0, dut.stage2[i]);
		end
		for (i = 0; i <= 2; i = i + 1) begin
			$dumpvars(0, dut.stage3[i]);
		end
		for (i = 0; i <= 1; i = i + 1) begin
			$dumpvars(0, dut.stage4[i]);
		end
		
		data = 8'hff;
		
		for (i = 0; i <= 31; i = i + 1) begin
			coef = i;
			#5;
		end
		#5 $finish;
	end
endmodule
