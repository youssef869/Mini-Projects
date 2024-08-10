// test for a switching freq = 2kHz
`timescale 1ns/1ns
module PWM_tb #(localparam R = 8, localparam T = 10
,localparam TIMER_BITS = 10)();

localparam SWITCHING_FREQ = 2000;
reg clk;
reg reset_n;
reg [R : 0] duty;
reg [TIMER_BITS-1:0] final_value;
wire PWM_out;

PWM #(.R(R) , .TIMER_BITS(TIMER_BITS)) DUT(
	.clk(clk),
	.reset_n(reset_n),
	.final_value(final_value),
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
	final_value = 195;
	@(negedge clk);
	reset_n = 1;

	duty = 0.5 * (2**R);
	#(5*(1.0/SWITCHING_FREQ) * (10**9));

	duty = 0.75 * (2**R);
	#(5*(1.0/SWITCHING_FREQ) * (10**9));

	duty = 0.25 * (2**R);
	#(5*(1.0/SWITCHING_FREQ) * (10**9));
	
	$stop;
end 

endmodule