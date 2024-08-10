module mux4x1(w0,w1,w2,w3,sel,out);
parameter N;
input [N-1:0] w0,w1,w2,w3;
input [1:0] sel;
output reg[N-1:0] out;

always @(*) begin
 	out = (sel == 2'b00) ? w0 :(sel == 2'b01) ? w1 :(sel == 2'b10) ? w2 :w3;
 end 
endmodule