module shift_register #(parameter N = 4)
(
	input s_in,
	input [N-1:0] p_in,
	input clk,load,reset_n,
	output s_out,
	output [N-1:0] p_out
);

reg [N-1:0] q_cs , q_ns;

//state memory
always @(posedge clk or negedge reset_n) begin
	if(!reset_n)
	    q_cs <= 0;
	else 
		q_cs <= q_ns;
end

//next state logic
always @(s_in,q_cs,load) begin
	if(load)
        q_ns = p_in;
	else 
	    q_ns = {s_in , q_cs[N-1:1]}; //shift right 
end 

//output logic
assign s_out = q_cs[0];
assign p_out = q_cs;
endmodule