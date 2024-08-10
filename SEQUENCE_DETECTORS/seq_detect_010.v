module seq_detect_010(x,clk,rst,y,count);

parameter IDLE   = 2'b00;
parameter ZERO   = 2'b01;
parameter ONE    = 2'b10;
parameter STORE  = 2'b11;

input x,clk,rst;
output reg y;
output reg [9:0] count;

reg [1:0] cs,ns;

//next state logic 
always @(cs,x) begin
	case(cs)
		IDLE: begin
			if(x)
				ns = IDLE;
			else 
				ns = ZERO;
		end 

		ZERO: begin
			if(x)
				ns = ONE;
			else 
				ns = ZERO;				
		end 

		ONE: begin
			if(x)
				ns = IDLE;
			else 
				ns = STORE;		
		end 

		STORE: begin
			if(x)
				ns = IDLE;
			else 
				ns = ZERO;					
		end 
		default : ns = IDLE;
	endcase
end
	
//state memory and count output
always @(posedge clk or posedge rst) begin
	if(rst) begin
		cs    <= IDLE;
		count <= 0;
	end 

	else begin
		cs <= ns;
		if(cs == STORE)
			count <= count + 1;
	end 
end 

//output y logic
always @(cs) begin
	if(cs == STORE) begin
		y = 1;
	end 
	else begin
		y = 0;
	end 
end 
endmodule 