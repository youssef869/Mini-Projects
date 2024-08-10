module LFSR(clk,rst_n,out);
parameter N = 8;
input clk;
input rst_n;
output reg [1 : N] out;

reg [1 : N] cs , ns;

wire msb;
assign msb = cs[8] ^ cs[6] ^ cs[5] ^ cs[4];

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		cs <= 'd1;
	end
	else begin
		cs <= ns;
	end
end

always @(cs) begin
	ns = {msb,cs[1 : N-1]};
end 

always @(cs) begin
	out = cs;
end 
endmodule