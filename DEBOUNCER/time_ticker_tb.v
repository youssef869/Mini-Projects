`timescale 1ns/1ns
module time_ticker_tb();

reg clk;
reg enable;
reg reset_n;
wire done;

localparam FINAL_VALUE = 10;
localparam T = 10;

time_ticker #(.FINAL_VALUE(FINAL_VALUE)) DUT
(	 .clk(clk),
	 .enable(enable),
	 .reset_n(reset_n),
	 .done(done)
);


initial begin
	clk = 0;
	forever 
		#(T/2) clk = ~clk;
end

initial begin
	reset_n = 0;
	enable = 1;
	#T;
	reset_n = 1;

	repeat(200) @(negedge clk);
	$stop;
end 
endmodule