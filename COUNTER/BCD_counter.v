module BCD_counter
(
	input clk,
	input enable,
	input reset_n,
	output done,
	output [3 : 0] count
);



reg [3 : 0] cs,ns;

assign done = (cs == 9);

//state memory
always @(posedge clk or negedge reset_n) begin
	if(~reset_n)
		cs <= 0;
	else if(enable)
		cs <= ns;
	else 
		cs <= cs;
end

//next state logic
always @(*) begin
	ns = done ? 0 : cs + 1;
end

//output logic 
assign count = cs;

endmodule