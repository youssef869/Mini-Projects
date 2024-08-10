module swapper_fsm(clk,reset_n,swap,w,sel);

input clk;
input swap;
input reset_n;
output w;
output [1:0] sel;

localparam S0 = 0;
localparam S1 = 1;
localparam S2 = 2;
localparam S3 = 3;

reg [1:0] cs,ns;

always @(posedge clk or negedge reset_n) begin
	if (~reset_n) begin
		// reset
		cs <= S0;
	end
	else begin
		cs <= ns;
	end
end

always @(*) begin
	case(cs)
		S0: begin
			if(swap)
				ns = S1;
			else 
				ns = S0;
		end 

		S1 : ns = S2;

		S2 : ns = S3;

		S3 : ns = S0;

	endcase
end 

assign w = (cs != S0);
assign sel = (cs == S0) ? 0 : (cs  == S1) ? 1 : (cs == S2) ? 2 : 3;

endmodule