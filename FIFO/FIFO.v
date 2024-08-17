module FIFO(din_a,wen_a,ren_b,clk_a,clk_b,rst,dout_b,full,empty);
parameter FIFO_WIDTH    = 16;
parameter FIFO_DEPTH    = 512;
localparam POINTER_SIZE = $clog2(FIFO_DEPTH);


input [FIFO_WIDTH-1 :0] din_a;
input wen_a,ren_b,clk_a,clk_b,rst;
output reg [FIFO_WIDTH-1 :0] dout_b;
output full , empty;

reg [FIFO_WIDTH-1 :0] mem [FIFO_DEPTH-1 :0];

reg [POINTER_SIZE-1:0] rd_ptr,wr_ptr;


assign full  = ( (rd_ptr[POINTER_SIZE] != wr_ptr[POINTER_SIZE]) && (wr_ptr[POINTER_SIZE-1:0] == rd_ptr[POINTER_SIZE-1:0]) );
assign empty = (rd_ptr == wr_ptr);


always @(posedge clk_a) begin
	if (rst) begin
		// reset
		wr_ptr <= 0;
	end
	/*

	else if(wen_a ^^ ~full)
	


	*/
	else begin
		if (wen_a) begin
			if(~full) begin
				mem[wr_ptr] <= din_a;
				if(wr_ptr == FIFO_DEPTH - 1)
					wr_ptr <= 0; //making it circular
				else
					wr_ptr <= wr_ptr + 1;
			end 
		end
	end
end


always @(posedge clk_b) begin
	if (rst) begin
		// reset
		dout_b <= 0;
		rd_ptr <= 0;
	end
	else begin

		if (ren_b) begin
			if(~empty) begin
				dout_b <= mem[rd_ptr];
				if(rd_ptr == FIFO_DEPTH - 1)
					rd_ptr <= 0; //making it circular
				else
					rd_ptr <= rd_ptr + 1;
			end 
		end
	end 
end

endmodule 