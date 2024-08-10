module time_ticker #(parameter TIMER_BITS = 4)
(	input clk,
	input [TIMER_BITS-1 :0] final_value,
	input enable,
	input reset_n,
	output done
);

reg [TIMER_BITS-1 : 0] cs,ns;

assign done = (cs == final_value);

//state memory
always @(posedge clk or negedge reset_n) begin
	if(~reset_n)
		cs <= 0;
	else if(enable)
		cs <= ns;
end

//next state logic
always @(*) begin
	ns = done ? 0 : cs + 1;
end

endmodule