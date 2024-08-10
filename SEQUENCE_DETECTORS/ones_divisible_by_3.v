module ones_divisible_by_3(clk,rst,in,y);
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

input clk,rst,in;
output reg y;

reg [1:0] cs,ns;

always @(cs,in) begin
	case(cs)
		S0: begin
			if(in)
				ns = S1;
			else 
				ns = S0;
		end 

		S1: begin
			if(in)
				ns = S2;
			else 
				ns = S1;
		end 

		S2: begin
			if(in)
				ns = S3;
			else 
				ns = S2;	
		end 

		S3: begin
			if(in)
				ns = S1;
			else 
				ns = S0;	
		end 

		default: ns = S0;
	endcase
end 

always @(posedge clk or posedge rst) begin
	if (rst) 
		cs <= S0;
	else 
		cs <= ns;
end

always @(cs,in) begin
	if(cs == S2 && in == 1)
		y = 1;
	else 
		y = 0;
end 

endmodule 