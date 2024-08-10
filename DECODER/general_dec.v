module general_dec(w,en,y);
parameter INPUT_WIDTH = 2;
localparam OUTPUT_WIDTH = 2**INPUT_WIDTH;
input [INPUT_WIDTH-1:0] w;
input en;
output reg [OUTPUT_WIDTH-1 : 0] y;

always @(*) begin
    y = 0;
	if(~en)
	    y = 'b0;
	else 
		y[w] = 1'b1;
end

endmodule