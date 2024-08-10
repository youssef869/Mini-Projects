module d_flipflop(d,clk,reset_n,clear_n,q,q_bar);
input d,clk;
input reset_n; //async preset , reset
input clear_n; //sync clear
output reg q;
output q_bar;

assign q_bar = ~q ;

always @(negedge clk or negedge reset_n) begin
	if(!reset_n || !clear_n)
		q <= 0;
	else
		q <= d;
end
endmodule