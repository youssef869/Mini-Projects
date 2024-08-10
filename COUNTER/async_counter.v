//async up counter
module async_counter #(parameter N = 4)
(
	input reset_n,clk,
	output [N-1:0] q
);

wire [N-1 : 0] counter;
generate
	genvar i;
	for(i = 0 ; i < N ; i = i+1)
	begin: TFF
		if(i == 0)
			tff FF(.t(1'b1) , .clk(clk) , .q(counter[0]),.reset_n(reset_n));
		else
			tff FF(.t(1'b1) , .clk(~counter[i-1]) , .q(counter[i]),.reset_n(reset_n));
	end
endgenerate

assign q = reset_n ? counter : 0;

endmodule