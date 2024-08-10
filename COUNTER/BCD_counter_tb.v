`timescale 1ns/1ns
module BCD_counter_tb();

localparam T  = 20;

reg clk;
reg reset_n;
reg enable;

wire [3 : 0] count;
wire done;

BCD_counter DUT
(
	 .reset_n(reset_n),
	 .enable(enable),
	 .clk(clk),
	 .done(done),
	 .count(count)
);

initial begin
	clk = 0;
	forever 
		#(T/2) clk = ~clk;
end

initial begin

	reset_n = 0;
	enable = 1;
	@(negedge clk);
	reset_n = 1;

	repeat(15) @(negedge clk);
	$stop;
end 

endmodule