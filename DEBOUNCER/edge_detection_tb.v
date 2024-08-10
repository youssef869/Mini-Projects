module edge_detection_tb();
reg clk     ;
reg reset_n ;
reg level;
wire p_edge ;
wire n_edge ;
wire edge_  ;

localparam T  = 10;

edge_detection DUT(.level(level),.clk(clk),.reset_n(reset_n),.p_edge(p_edge),.n_edge(n_edge),.edge_(edge_));

initial begin
	clk = 0;
	forever 
		#(T/2) clk = ~clk;
end

initial begin
	reset_n = 0;
	@(negedge clk);
	reset_n = 1;
	level = 0;
	repeat(100) begin
		@(negedge clk);
		level = ~level;
	end 
	$stop;


end 


endmodule