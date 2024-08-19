`timescale 1ns/1ps
module jk_ff_tb();
reg j;
reg k;
reg rst_n;
reg clk;
wire  q;
wire  q_n;

jk_ff DUT(
j,
k,
rst_n,
clk,
q,
q_n
);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	rst_n = 0;
	@(negedge clk);
	rst_n = 1;


	j = 1;
	k = 0;
	repeat(10) @(negedge clk);

	j = 1;
	k = 1;
	repeat(10) @(negedge clk);

	j = 0;
	k = 0;
	repeat(10) @(negedge clk);

	j = 0;
	k = 1;
	repeat(10) @(negedge clk);

	$stop;			

end 
endmodule