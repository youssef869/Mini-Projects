module mux2x1(w0,w1,sel,out);
parameter N;
input [N-1:0] w0,w1;
input sel;
output reg [N-1:0] out;

always @(w0 or w1 or sel) begin
	out = sel ? w1 : w0;
end
endmodule