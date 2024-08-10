module basic_PWM #(parameter R = 8)(
	input clk,
	input reset_n,
	input [R-1 : 0] duty,
	output PWM_out
);

reg [R-1 : 0] cs , ns;
//state memory
always @(posedge clk or negedge reset_n) begin
	if (~reset_n)
		cs <= 0;
	else
		cs <= ns;
end

//next state logic
always @(cs) begin
	ns = cs + 1;
end 


//output logic

assign PWM_out = (cs < duty);
endmodule