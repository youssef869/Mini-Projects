module parallel_register_beh
#(parameter N = 8)
(
	input [N-1:0]d,
	input clk,
	input load,
    output [N-1:0]q
);

reg [N-1:0] q_cs;
wire [N-1:0] q_ns;

/*
	simply can done using one always block but it is divided for
	ease of debugging and making it systematic
*/

//state memory
always @(posedge clk) begin
	q_cs <= q_ns;
end

//next state logic
assign q_ns = load ? d : q_cs;

//output logic 
assign q = q_cs;

endmodule