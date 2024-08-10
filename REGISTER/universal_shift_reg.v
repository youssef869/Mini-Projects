module universal_shift_reg #(parameter N = 4)
(
	input msb_in,lsb_in,
	input [N-1:0] p_in,
	input clk,reset_n,
	input [1:0] select,
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
always @(select,q_cs,msb_in,lsb_in,p_in) begin
	q_ns = q_cs; //default value
    case(select)
    	2'b00: q_ns = q_cs;
    	2'b01: q_ns = {msb_in, q_cs[N-1:1]}; //shift right
    	2'b10: q_ns = {q_cs[N-2:1],lsb_in}; //shift left
    	2'b11: q_ns = p_in;

    	default : q_ns = q_cs;
    endcase     
end 

//output logic
assign p_out = q_cs;
endmodule