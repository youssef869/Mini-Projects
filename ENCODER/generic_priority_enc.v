module generic_priority_enc(w,y,z);

parameter INPUT_SIZE = 4;
localparam OUTPUT_SIZE = $clog2(INPUT_SIZE);

input [INPUT_SIZE-1:0] w;
output reg [OUTPUT_SIZE-1:0] y;
output z;
integer i;

assign  z = |w;

always @(w) begin
	for(i = 0; i<INPUT_SIZE ; i = i+1) begin
		if(w[i])
			y = i;
		else 
			y = 'bx;
	end
end

endmodule