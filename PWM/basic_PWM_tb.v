module basic_PWM_tb #(localparam R = 10, localparam T = 20)();

reg clk;
reg reset_n;
reg [R-1 : 0] duty;
wire PWM_out;

basic_PWM #(.R(R)) DUT(
	.clk(clk),
	.reset_n(reset_n),
	.duty(duty),
	.PWM_out(PWM_out)
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

	duty = 0.5 * (2**R);
	repeat(2* (2**R)) @(negedge clk);

	duty = 0.75 * (2**R);
	repeat(2* (2**R)) @(negedge clk);

	duty = 0.25 * (2**R);
	repeat(2* (2**R)) @(negedge clk);
	$stop;
end 

endmodule
