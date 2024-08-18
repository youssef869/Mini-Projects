module FIFO(din_a,wen_a,ren_b,clk_a,clk_b,rst,dout_b,full,empty);
parameter FIFO_WIDTH    = 16;
parameter FIFO_DEPTH    = 512;
localparam POINTER_SIZE = $clog2(FIFO_DEPTH);


input [FIFO_WIDTH-1 :0] din_a;
input wen_a,ren_b,clk_a,clk_b,rst;
output reg [FIFO_WIDTH-1 :0] dout_b;
output full , empty;

reg [FIFO_WIDTH-1 :0] mem [FIFO_DEPTH-1 :0];

reg [POINTER_SIZE:0] rd_ptr,wr_ptr;


assign full  = ( (rd_ptr[POINTER_SIZE] != wr_ptr[POINTER_SIZE]) && (wr_ptr[POINTER_SIZE-1:0] == rd_ptr[POINTER_SIZE-1:0]) );
assign empty = (rd_ptr == wr_ptr);


always @(posedge clk_a) begin
	if (rst) begin
	        // reset
		wr_ptr <= 0;
	end
	else if (wen_a && !full)  begin
	        mem[wr_ptr] <= din_a;
	        wr_ptr <= wr_ptr + 1;
	end	
end


always @(posedge clk_b) begin
	if (rst) begin
		// reset
		dout_b <= 0;
		rd_ptr <= 0;
	end
	else if (ren_b && !empty) begin
		dout_b <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
end
endmodule 
