module seq_detect_010_1001(x,clk,reset_n,out);
input x;
input clk;
input reset_n;
output out;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;

reg [2:0] cs , ns;

always @(posedge clk or negedge reset_n) begin
	if (~reset_n) begin
		cs <= S0;
	end
	else begin
		cs <= ns;
	end
end
always @(cs,x) begin
	case(cs)
		S0: begin

			if(x) begin
				ns = S4;
			end 

			else begin
				ns = S1;
			end

		end 

		S1: begin

			if(x) begin
				ns = S2;
			end 

			else begin
				ns = S1;
			end		

		end 

		S2: begin
		
			if(x) begin
				ns = S4;
			end 

			else begin
				ns = S3;
			end

		end

		S3: begin
		
			if(x) begin
				ns = S2;
			end 

			else begin
				ns = S5;
			end

		end 

		S4: begin
		
			if(x) begin
				ns = S4;
			end 

			else begin
				ns = S3;
			end

		end 

		S5: begin
		
			if(x) begin
				ns = S2;
			end 

			else begin
				ns = S1;
			end

		end 
		
		default: ns = S0;				 		
	endcase
end


assign out = ((cs == S2) && (x == 0)) || ((cs == S5) && (x == 1));

endmodule