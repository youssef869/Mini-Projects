//delay detection debouncer
module debouncer(noisy_in,clk,reset_n,debounce_out);

parameter FINAL_VALUE = 2000000; //debounce delay in ns

input noisy_in;
input clk;
input reset_n;
output debounce_out;

wire timer_done , timer_reset;
time_ticker #(.FINAL_VALUE(FINAL_VALUE)) timer(
	.clk(clk),
	.enable(1),
	.reset_n(~timer_reset),
	.done(timer_done)
	);

debouncer_fsm fsm(
	.noisy_in(noisy_in),
	.clk(clk),
	.reset_n(reset_n),
	.timer_done(timer_done),
	.timer_reset(timer_reset),
	.debounce_out(debounce_out)
	);

endmodule 