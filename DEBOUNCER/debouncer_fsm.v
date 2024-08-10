module debouncer_fsm(noisy_in,clk,reset_n,timer_done,timer_reset,debounce_out);
input noisy_in;
input clk;
input reset_n;
input timer_done;
output timer_reset;
output debounce_out;

parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;

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
		S0:
		 begin
		  if(noisy_in)
		  	ns = S1;
		  else
		  	ns = S0;
		 end

		S1:
		 begin
		  if(noisy_in) begin
		  	if(timer_done)
		  		ns = S2;
		  	else 
		  		ns = S1;
		  end 
		  else
		  	ns = S0;
		 end

		S2:
		 begin
		  if(noisy_in)
		  	ns = S2;
		  else
		  	ns = S3;
		 end

		S3:
		 begin
		  if(noisy_in)
		  	ns = S2;
		  else if(timer_done)
		  	ns = S0;
		  else 
		  	ns = S3;
		 end
	endcase

end 

assign timer_reset  = (cs == S0) || (cs == S2);
assign debounce_out = (cs == S2) || (cs == S3);

endmodule