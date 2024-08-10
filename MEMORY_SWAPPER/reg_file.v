// 2^N * BITS register file
module reg_file(clk,address_w,we,data_w,address_r,data_r);
parameter N = 8;
parameter BITS = 32;
localparam DIPTH = 2**N;

input clk;
input [N-1 : 0] address_w;
input we;
input [BITS-1 : 0] data_w;
input [N-1 : 0] address_r;
output [BITS-1 : 0] data_r;

reg [BITS-1 : 0] rf [DIPTH-1 : 0];


always @(posedge clk) begin
	if(we)
		rf[address_w] <= data_w;
end

assign data_r = rf[address_r];

endmodule