module tff(
	input t,clk,reset_n,
	output reg q
);

reg q_cs,q_ns;

//state memory
always @(posedge clk or negedge reset_n) begin
	if(~reset_n)
		q_cs <= 0;
	else
		q_cs <= q_ns;
end


//next state logic
always @(q_cs or t) begin
	if(t)
		q_ns = ~q_cs;
	else 
		q_ns = q_cs;
end 


//output logic
always @(q_cs) begin
	q = q_cs;
end 
endmodule