module FIFO_tb();
parameter FIFO_WIDTH    = 16;
parameter FIFO_DEPTH    = 512;

reg [FIFO_WIDTH-1 :0] din_a;
reg wen_a,ren_b,clk_a,clk_b,rst;
wire [FIFO_WIDTH-1 :0] dout_b;
wire full , empty;

FIFO #(.FIFO_WIDTH(FIFO_WIDTH) , .FIFO_DEPTH(FIFO_DEPTH)) dut(.din_a(din_a),.wen_a(wen_a),
	   .ren_b(ren_b),.clk_a(clk_a),.clk_b(clk_b),.rst(rst),.dout_b(dout_b),
	   .full(full),.empty(empty));

initial begin
	clk_a = 0;
	forever
		#10 clk_a = ~clk_a;
end

initial begin
	clk_b = 0;
	forever
		#20 clk_b = ~clk_b; //different frequency
end

initial begin
	rst = 1;
	@(negedge clk_a);
	@(negedge clk_b);
	rst = 0;

	// writing(enqeue)

	wen_a = 1;
	ren_b = 0;
	repeat(FIFO_DEPTH) begin
		din_a = $random;
		@(negedge clk_a);
	end 

	//reading first element then write to check if it's circular or not
	wen_a = 0;
	ren_b = 1;
	@(negedge clk_b);
	wen_a = 1;
	ren_b = 0;
	din_a = $random;
	@(negedge clk_a);

	//writing into a full FIFO
	wen_a = 1;
	ren_b = 0;
	repeat(10) begin
		din_a = $random;
		@(negedge clk_a);
	end

	//reading(deqeue)
	wen_a = 0;
	ren_b = 1;
	repeat(FIFO_DEPTH) begin
		@(negedge clk_b);
	end

	//reading from an empty FIFO
	repeat(10) begin
		@(negedge clk_b);
	end

	//enqeue and deqeue together
	
	//first write some data in the empty FIFO
	wen_a = 1;
	ren_b = 0;
	repeat(100) begin
		din_a = $random;
		@(negedge clk_a);
	end 
	ren_b = 1;
	repeat(100) begin
		din_a = $random;
		@(negedge clk_a);
		@(negedge clk_b);
	end 
$stop;
end 
endmodule 