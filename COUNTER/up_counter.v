module up_counter #(parameter N = 4)
(
	input clk,
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
always @(cs) begin
	if(&cs)
		ns = 0;
	else 
		ns = cs + 1;
end

//output logic 

assign count = cs;
endmodule