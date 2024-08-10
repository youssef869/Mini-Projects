`timescale 1ns/1ns
module modulus_counter_tb();

localparam T  = 20;
localparam FINAL_VALUE = 9; // works as BCD counter
localparam SIZE = $clog2(FINAL_VALUE);

reg clk;
reg reset_n;
reg enable;

wire [SIZE-1 : 0] count;

modulus_counter #(.FINAL_VALUE(FINAL_VALUE)) DUT
(
	 .reset_n(reset_n),
	 .enable(enable),
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
	enable = 1;
	@(negedge clk);
	reset_n = 1;

	repeat(FINAL_VALUE + 2) @(negedge clk);
	$stop;
end 

endmodule