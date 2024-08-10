module seq_detect_010_1001_tb();

reg x;
reg clk;
reg reset_n;
wire out;

localparam T = 20;

seq_detect_010_1001 DUT(.x(x),.clk(clk),.reset_n(reset_n),.out(out));
initial begin
	clk = 0;
	forever
		#(T/2) clk = ~clk;
end

initial begin
	reset_n = 0;
	@(negedge clk);
	reset_n = 1;

	x = 0;
	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 1;
	@(negedge clk);
	x = 0;

	@(negedge clk);
	x = 1;
	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 1;

	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 1;

	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 0;
	@(negedge clk);
	x = 1;
	@(negedge clk);
	x = 1;
	@(negedge clk);
	x = 0;
	@(negedge clk);	

	$stop;
end

endmodule
