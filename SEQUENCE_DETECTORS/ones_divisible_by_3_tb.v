module ones_divisible_by_3_tb();
reg clk,rst,in;
wire y;

ones_divisible_by_3 dut(.clk(clk),.rst(rst),.in(in),.y(y));

initial begin
	clk = 0;
	forever 
		#10 clk = ~clk;
end

initial begin
	rst = 1;
	@(negedge clk);
	rst = 0;

	in = 1;
	@(negedge clk);	
	in = 1;
	@(negedge clk);	
	in = 1;
	@(negedge clk);	

	in = 0;
	repeat(100) begin
		in = $random;
		@(negedge clk);		
	end 
	$stop; 
end
endmodule