`timescale 10ns/1ns
module d_flipflop_tb();
reg d_tb,clk_tb;
reg clear_n_tb,reset_n_tb;
wire q_tb;
wire q_bar_tb;

localparam T = 20;//clock period

d_flipflop DUT(.d(d_tb),.clk(clk_tb),.q(q_tb),.q_bar(q_bar_tb),.clear_n(clear_n_tb),.reset_n(reset_n_tb));
initial begin
	clk_tb = 0;
	forever
		#(T/2) clk_tb = ~clk_tb;
end

initial begin
	reset_n_tb = 0;
	clear_n_tb = 1;
	d_tb = 1;
	repeat(10) @(posedge clk_tb);
	reset_n_tb = 1;
	clear_n_tb = 0;
	d_tb = 1;
	repeat(10) @(posedge clk_tb);

	clear_n_tb = 1;

	repeat(50) begin
		d_tb = $random;
		@(posedge clk_tb);
	end 
	$stop;
end 
endmodule