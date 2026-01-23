`timescale 1ns / 1ns

module df_multiplier_c3_tb;
	
	integer i;
	
	reg [7:0] data;
	wire [7:0] out;
	
	wire [7:0] c;
	wire [15:0] mul;
	
	df_multiplier_c3 dut(data, out);
	
	assign c = 8'b00011011;
	
	assign mul = data * c;
	
	initial begin
		$dumpfile("df_multiplier_c3_tb.vcd");
		$dumpvars;
		for (i = 0; i <= 3; i = i + 1) begin
			$dumpvars(0, dut.stage1[i]);
		end
		for (i = 0; i <= 2; i = i + 1) begin
			$dumpvars(0, dut.stage2[i]);
		end
		for (i = 0; i <= 1; i = i + 1) begin
			$dumpvars(0, dut.stage3[i]);
		end
		
		data = 8'h00;
		
		for (i = 0; i <= 255; i = i + 51) begin
			data = i;
			#5;
		end
		#5 $finish;
	end
endmodule
