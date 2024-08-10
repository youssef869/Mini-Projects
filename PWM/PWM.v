module PWM #(parameter R = 8, parameter TIMER_BITS = 8)(
	input clk,
	input reset_n,
	input [TIMER_BITS-1:0] final_value,
	input [R : 0] duty,
	output PWM_out
);

wire enable;
reg [R-1 : 0] cs , ns;
reg out_cs , out_ns;

time_ticker #(.TIMER_BITS(TIMER_BITS)) timer(
	.clk(clk),
	.final_value(final_value),
	.enable(1'b1),
	.reset_n(reset_n),
	.done(enable)
	);

//state memory
always @(posedge clk or negedge reset_n) begin
	if (~reset_n) begin
		cs <= 0;
		out_cs <= 0;
	end
	else if(enable) begin
		cs <= ns;
		out_cs <= out_ns;
	end 
end

//next state logic
always @(*) begin
	ns = cs + 1;
	out_ns = (cs < duty);
end 


//output logic
assign PWM_out = out_cs ;
endmodule