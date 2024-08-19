module jk_ff(
input wire j,
input wire k,
input wire rst_n,
input wire clk,
output reg  q,
output wire  q_n
);

reg q_ns;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		// reset
		q <= 1'b0;
	end
	else begin
		q <= q_ns;
	end
end

always @(*) begin
	q_ns = q;
	case({j,k})
		2'b00: q_ns = q;
		2'b01: q_ns = 1'b0;
		2'b10: q_ns = 1'b1;
		2'b11: q_ns = !q;
		default: q_ns = q;
	endcase
	 
end 

assign q_n = !q;

endmodule