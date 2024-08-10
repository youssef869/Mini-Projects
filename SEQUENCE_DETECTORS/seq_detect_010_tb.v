module seq_detect_010_tb();

reg x,clk,rst;
wire y;
wire [9:0] count;

seq_detect_010 dut(.x(x),.clk(clk),.rst(rst),.y(y),.count(count));

initial begin
	clk = 0;
	forever 
		#10 clk = ~clk;
end

initial begin
	rst = 1;
	@(negedge clk);

	rst = 0;
	x = 0;
	@(negedge clk);
	x = 1;
	@(negedge clk);
	x = 0;
	@(negedge clk);

	x = 1;
	@(negedge clk);


	repeat(100) begin
		x = $random;
		@(negedge clk);
	end 
$stop;
end 
endmodule 