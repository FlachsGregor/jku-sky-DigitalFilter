// Copyright 2025 Gregor Flachs
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE−2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

`timescale 1ns / 1ps

module df_digital_filter_tb;
	
	// 50 MHz clock/sampling rate
	parameter half_clk_period = 10;
	parameter clk_period = 2 * half_clk_period;
	
	parameter min_data_val = 8'h00;
	parameter max_data_val = 8'hff;
	parameter clk_cycles_per_signal = 250;
	
	parameter uio_en = 3;
	parameter uio_hp = 2;
	parameter uio_wg1 = 1;
	parameter uio_wg0 = 0;
	
	parameter lowpass = 1'b0;
	parameter highpass = 1'b1;
	parameter [1:0] wg_0125 = 2'b00;
	parameter [1:0] wg_0375 = 2'b01;
	parameter [1:0] wg_0625 = 2'b10;
	parameter [1:0] wg_0875 = 2'b11;
	
	parameter w_0_04 = 25;
	parameter w_0_10 = 10;
	parameter w_0_20 = 5;
	parameter w_0_25 = 4;
	parameter w_0_33 = 3;
	parameter w_0_50 = 2;
	parameter w_1_00 = 1;
	
	reg clk   = 1'b0;
	reg rst_n = 1'b0;
	
	reg [7:0] ui_in;
	reg [3:0] uio_in;
	
	wire [7:0] uo_out;
	
	df_digital_filter df_top(
		.CLK(clk),
		.nRST(rst_n),
		.enconfig(uio_in[3]),
		.configin(uio_in[2:0]),
		.datain(ui_in),
		.dataout(uo_out)
	);
	
	task change_config;
		input hp;
		input [1:0] wg;
	begin
		#(clk_period);
		
		uio_in[uio_en] = 1'b1;
		uio_in[uio_hp] = hp;
		uio_in[uio_wg1] = wg[1];
		uio_in[uio_wg0] = wg[0];
		#(clk_period);
		
		uio_in[uio_en] = 1'b0;
		uio_in[uio_hp] = 1'b0;
		uio_in[uio_wg1] = 1'b0;
		uio_in[uio_wg0] = 1'b0;
		#(clk_period);
	end
	endtask
	
	task gen_rect_signal;
		input integer half_prescaler;
		integer number_of_periods;
		integer half_period_length;
		integer i;
	begin
		number_of_periods = clk_cycles_per_signal / (2 * half_prescaler);
		half_period_length = clk_period * half_prescaler;
		
		for (i = 0; i < number_of_periods; i = i + 1) begin
			ui_in = min_data_val;
			#(half_period_length);
			ui_in = max_data_val;
			#(half_period_length);
		end
		
		ui_in = min_data_val;
	end
	endtask
	
	task gen_trian_signal;
		input integer half_prescaler;
		integer number_of_periods;
		integer i, j;
	begin
		number_of_periods = clk_cycles_per_signal / (2 * half_prescaler);
		
		for (i = 0; i < number_of_periods; i = i + 1) begin
			for (j = 0; j < half_prescaler; j = j + 1) begin
				ui_in = $rtoi(max_data_val * (j / $itor(half_prescaler)));
				#(clk_period);
			end
			
			for (j = half_prescaler; j > 0; j = j - 1) begin
				ui_in = $rtoi(max_data_val * (j / $itor(half_prescaler)));
				#(clk_period);
			end
		end
		
		ui_in = min_data_val;
	end
	endtask
	
	task gen_sine_signal;
		input integer half_prescaler;
		integer number_of_periods;
		integer clk_cycles_per_period;
		integer i, j;
		real pi;
	begin
		number_of_periods = clk_cycles_per_signal / (2 * half_prescaler);
		clk_cycles_per_period = 2 * half_prescaler;
		pi = 3.14159265359;
		
		for (i = 0; i < number_of_periods; i = i + 1) begin
			for (j = 0; j < clk_cycles_per_period; j = j + 1) begin
				ui_in = $rtoi(max_data_val * ($sin(2*pi*j/clk_cycles_per_period) / 2 + 0.5));
				#(clk_period);
			end
		end
		
		ui_in = min_data_val;
	end
	endtask
	
	task gen_dirac_impulse;
	begin
		ui_in = min_data_val;
		#(9 * clk_period);
		
		ui_in = max_data_val;
		#(clk_period);
		
		ui_in = min_data_val;
		#(clk_period * (clk_cycles_per_signal - 10));
	end
	endtask
	
	always #(half_clk_period) clk = ~clk;
	
	initial begin
		$dumpfile("df_digital_filter_tb.vcd");
		$dumpvars;
		
		rst_n = 1'b0;
		ui_in = 8'b0;
		uio_in = 4'b0;
		
		#(5 * clk_period);
		
		rst_n = 1'b1;
		
		#(clk_period);
		
		change_config(lowpass, wg_0125);
		
		gen_rect_signal(w_0_04);
		gen_trian_signal(w_0_50);
		gen_sine_signal(w_0_10);
		
		change_config(highpass, wg_0875);
		
		gen_rect_signal(w_0_10);
		gen_trian_signal(w_1_00);
		gen_sine_signal(w_0_25);
		
		change_config(lowpass, wg_0625);
		
		gen_rect_signal(w_0_04);
		gen_trian_signal(w_0_50);
		gen_sine_signal(w_0_20);
		
		change_config(highpass, wg_0375);
		
		gen_rect_signal(w_0_10);
		gen_trian_signal(w_1_00);
		gen_sine_signal(w_0_33);
		
		$finish;
	end
endmodule
