`timescale 1ns/1ns
module up_down_counter_tb();

localparam T  = 20;
localparam N = 4;

reg clk;
reg reset_n;
reg enable;
reg up;
reg [N-1 : 0] data;
reg load;
wire [N-1 : 0] count;

up_down_counter #(.N(N)) DUT
(
	 .reset_n(reset_n),
	 .enable(enable),
	 .up(up),
	 .load(load),
	 .data(data),
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
	up = 1;
	load = 0;
	data = 6;
	@(negedge clk);
	reset_n = 1;

	repeat(50) @(negedge clk);

	enable = 0;
	repeat(5) @(negedge clk);
	enable = 1;

	load = 1;
	@(negedge clk);
	load = 0;

	enable = 1;
	up = 0;
	repeat(50) @(negedge clk);

	$stop;
end 

endmodule