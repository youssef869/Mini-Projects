module time_ticker #(parameter final_value = 100)
(	input clk,
	input enable,
	input reset_n,
	output done,
);

localparam TIMER_BITS = $clog2(final_value);

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