`timescale 1ns/1ns
module debouncer_tb();

localparam FINAL_VALUE = 20_00000;
localparam T  = 10;
localparam DELAY  = 50_000_000; //debounce delay in ns

reg noisy_in;
reg clk;
reg reset_n;
wire debounce_out;

//note that moore output is delayed one cycle so we want onlt (FINAL_VALUE - 1) cycles from timer.
debouncer #(.FINAL_VALUE(FINAL_VALUE - 1)) DUT(.noisy_in(noisy_in),.clk(clk),.reset_n(reset_n),.debounce_out(debounce_out));

initial begin
	clk = 0;
	forever 
		#(T/2) clk = ~clk;
end

initial begin
	reset_n = 0;
	noisy_in = 0;
	#2 reset_n = 1;

	repeat(2) @(negedge clk);
	noisy_in = 1;
	
	#(DELAY);
	noisy_in = 0;
	#(DELAY);

	repeat(20) @(negedge clk);


	noisy_in = 0;
	#(DELAY/50);
	noisy_in =  1;
	repeat(5) 
		#(DELAY/100) noisy_in = ~noisy_in;

	repeat(5) 
		#(DELAY/50) noisy_in = ~noisy_in;

	repeat(5) 
		#(DELAY/200) noisy_in = ~noisy_in;

	noisy_in = 1;
	#(DELAY);
	repeat(20) @(negedge clk);

	noisy_in = 0;
	#(DELAY/50);

	repeat(5) 
		#(DELAY/100) noisy_in = ~noisy_in;

	repeat(5) 
		#(DELAY/50) noisy_in = ~noisy_in;

	repeat(5) 
		#(DELAY/200) noisy_in = ~noisy_in;

	noisy_in = 0;
	#(DELAY);
	repeat(20) @(negedge clk);
		
	$stop;
end 

endmodule 