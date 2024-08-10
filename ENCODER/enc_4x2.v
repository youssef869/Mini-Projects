module enc_4x2(w,y);
input [3:0] w;
output reg [1:0] y;

always @(w) begin
	y = 'bx; //default value
	if(w == 4'b0001)
		y = 0;
	else if(w == 4'b0010)
		y = 1;
	else if(w == 4'b0100)
		y = 2;
	else if(w == 4'b1000)
		y = 3;
	else 
		y = 'bx; // default value for remaining cases (should not happen)
end
endmodule