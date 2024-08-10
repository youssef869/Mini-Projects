`timescale 1ns/1ps
module d_latch_tb();
reg d_tb,clk_tb;
wire q_tb;
wire q_bar_tb;

localparam T = 20;

d_latch DUT(.d(d_tb),.clk(clk_tb),.q(q_tb),.q_bar(q_bar_tb));

initial begin
	clk_tb = 0;
	forever
		#(T/2) clk_tb = ~clk_tb;
end

initial begin
	repeat(50) begin
		d_tb = $random;
		@(negedge clk_tb);
	end 
	$stop;
end 
endmodule