module d_latch(d,clk,q,q_bar);
input d,clk;
output reg q;
output q_bar;
assign q_bar = ~q ;

always @(d or clk) begin
	if(clk) begin
		q <= d;
	end 
end
endmodule