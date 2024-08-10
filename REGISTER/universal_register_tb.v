`timescale 10ns/1ns
module universal_register_tb();

localparam N = 4;
localparam T = 20;

reg msb_in,lsb_in;
reg [N-1:0] p_in;
reg clk,reset_n;
reg [1:0] select;
wire [N-1:0] p_out;

universal_shift_reg #(.N(N)) DUT
(
	.msb_in(msb_in),
	.lsb_in(lsb_in),
	.p_in(p_in),
	.clk(clk) ,
	.reset_n(reset_n),
	.select(select),
	.p_out(p_out)
);

initial begin
	clk = 0;
	forever 
	#(T/2)	clk = ~clk;
end

initial begin
	msb_in = 1;
	lsb_in = 1;
	reset_n = 0;
	p_in = 'b0110;
	select = 2'b11;
	@(negedge clk);
	reset_n = 1;

	select = 2'b00;
	repeat(10) begin
		p_in = $random;
		msb_in = $random;
		lsb_in = $random;
		@(negedge clk);
	end 

	select = 2'b01;
	repeat(10) begin
		p_in = $random;
		msb_in = $random;
		lsb_in = $random;
		@(negedge clk);
	end 

	select = 2'b10;
	repeat(10) begin
		p_in = $random;
		msb_in = $random;
		lsb_in = $random;
		@(negedge clk);
	end 

	select = 2'b11;
	repeat(10) begin
		p_in = $random;
		msb_in = $random;
		lsb_in = $random;
		@(negedge clk);
	end 			
	$stop;
end 
endmodule
