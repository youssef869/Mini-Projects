module parallel_register_str
#(parameter N = 8)
(
	input [N-1:0]d,
	input clk,
    output [N-1:0]q
);

generate
	genvar i;
	for(i = 0; i<N; i=i+1) begin: ff
		dff ff(.d(d[i]) , .clk(clk) , .q(q[i]));
	end
endgenerate

endmodule