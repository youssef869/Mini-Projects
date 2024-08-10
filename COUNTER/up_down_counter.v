//up down counter with load
module up_down_counter #(parameter N = 4)
(
	input clk,
	input enable,
	input load,
	input [N-1 : 0] data,
	input up,
	input reset_n,
	output [N-1 : 0] count
);

reg [N-1 : 0] cs,ns;

//state memory
always @(posedge clk or negedge reset_n) begin
	if(~reset_n)
		cs <= 0;
	else 
		cs <= ns;
end

//next state logic
always @(*) begin
	if(~enable)
		ns = cs;
	else if(load)
		ns = data;
	else if(up)
		ns = cs + 1;
	else 
		ns = cs - 1;
end

//output logic 
assign count = cs;

endmodule