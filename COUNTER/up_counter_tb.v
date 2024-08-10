`timescale 1ns/1ps
module up_counter_tb();

localparam T  = 20;
localparam N = 4;

reg clk;
reg reset_n;
wire [N-1 : 0] count;

up_counter #(.N(N)) DUT
(
	 .reset_n(reset_n),
	 .clk(clk),
	 .count(count)
);

initial begin
	clk = 0;
	forever 
		#(T/2) clk = ~clk;
end

initial begin

	reset_n = 0;
	@(negedge clk);
	reset_n = 1;

	repeat(50) @(negedge clk);

	$stop;
end 

endmodule