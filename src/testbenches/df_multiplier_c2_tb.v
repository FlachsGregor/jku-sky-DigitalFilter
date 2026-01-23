`timescale 1ns / 1ns

module df_multiplier_c2_tb;

	integer i;
	
	reg [2:0] coef;
	reg [7:0] data;
	wire [7:0] out;
	
	wire [7:0] c;
	wire [15:0] mul;
	
	df_multiplier_c2 dut(coef, data, out);
	
	assign c = {1'b0, coef[2], 1'b0, coef[1], 1'b1, coef[0], 2'b10};
	
	assign mul = data * c;
	
	initial begin
		$dumpfile("df_multiplier_c2_tb.vcd");
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
		
		for (i = 0; i <= 7; i = i + 1) begin
			coef = i;
			#5;
		end
		#5 $finish;
	end
endmodule
