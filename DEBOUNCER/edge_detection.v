module edge_detection(level,clk,reset_n,p_edge,n_edge,edge_);
input level   ;
input clk     ;
input reset_n ;
output p_edge ;
output n_edge ;
output edge_  ;

parameter S0 = 0;
parameter S1 = 1;

reg cs , ns;
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
			if(level)
				ns = S1;
			else 
				ns = S0;
		end 

		S1: begin
			if(level)
				ns = S1;
			else 
				ns = S0;
		end
	endcase
end 

assign p_edge = (cs == S0) && (level);
assign n_edge = (cs == S1) && (~level);
assign edge_  = p_edge || n_edge;

endmodule