`timescale 1ns/1ps
module LFSR_tb();
localparam N = 8;
localparam T = 20;
reg clk;
reg rst_n;
wire [N-1 : 0] out;

LFSR #(.N(N)) DUT(.clk(clk),.rst_n(rst_n),.out(out));

initial begin
	clk = 0;
	forever 
		#(T/2) clk = ~clk;
end

initial begin
	rst_n = 0;
	@(negedge clk);
	rst_n = 1;
	repeat(2**N) @(negedge clk);
	$stop;
end 

endmodule