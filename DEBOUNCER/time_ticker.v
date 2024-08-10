module time_ticker #(parameter FINAL_VALUE = 100)
(	input clk,
	input enable,
	input reset_n,
	output done

);

localparam TIMER_BITS = $clog2(FINAL_VALUE);

reg [TIMER_BITS-1 : 0] cs,ns;


assign done = (cs == FINAL_VALUE);

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