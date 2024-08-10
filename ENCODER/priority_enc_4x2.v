module priority_enc_4x2(w,y,z);
input [3:0] w;
output reg[1:0] y;
output z;

assign z = |w; // will be one when at least one of w's bits is one

always @(*) begin
	y = 'bx;
	if (w[3])
		y = 3 ;
	else if(w[2])
		y = 2 ;
	else if(w[1])
		y = 1 ;
	else if(w[0])
		y = 0 ;
	else 
		y = 'bx;

end
endmodule