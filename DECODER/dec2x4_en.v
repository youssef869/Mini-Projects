module dec2x4_en(w,en,y);
input [1:0] w;
input en;
output reg [0:3] y;

always @(*) begin
    y = 0;
	if(~en)
	    y = 0;
	else 
		y[w] = 1;
	

end
endmodule