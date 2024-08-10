`timescale 1ns/1ns
module memory_swapper_tb();
localparam N = 7;
localparam BITS = 8;
localparam T = 10;

reg clk;
reg swap;
reg reset_n;
reg we;
reg [N-1 : 0] address_w;
reg [N-1 : 0] address_r;
reg [N-1 : 0] address_A;
reg [N-1 : 0] address_B;
reg [BITS-1 : 0] data_w;
wire [BITS-1 : 0] data_r;

integer i;

memory_swapper #(.N(N) ,.BITS(BITS))
 DUT(.clk(clk),.address_w(address_w),.we(we),.data_w(data_w),.address_r(address_r)
 	 ,.address_A(address_A),.address_B(address_B),.swap(swap),.reset_n(reset_n)
 	 ,.data_r(data_r));

initial begin
	clk = 0;
	forever 	
		#(T/2) clk = ~clk;
end

initial begin
	reset_n = 0;
	swap = 0;
	we = 1;
	
	@(negedge clk);
	reset_n = 1;


	
	///////// normal write /////////
	for(i = 0; i < 100; i = i+1) begin
		address_w = i;
		data_w =  i;
		@(negedge clk);
	end  

	we = 0;	


	///////// normal read /////////
	for(i = 20; i < 50; i = i+1) begin
		address_r  = i;
		@(negedge clk);
	end 

	///////// swap operation /////////
	swap = 1;
	address_A = 1;
	address_B = 2;

	repeat(3) @(negedge clk);

	swap = 0;
	@(negedge clk);

	$stop;
end 
endmodule