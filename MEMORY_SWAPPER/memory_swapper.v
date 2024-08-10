module memory_swapper(clk,address_w,we,data_w,address_r,address_A,address_B,swap,reset_n,data_r);
parameter N = 8;
parameter BITS = 32;

input clk;
input swap;
input reset_n;
input we;
input [N-1 : 0] address_w;
input [N-1 : 0] address_r;
input [N-1 : 0] address_A;
input [N-1 : 0] address_B;
input [BITS-1 : 0] data_w;
output [BITS-1 : 0] data_r;

reg [N-1 : 0] address_write,address_read;
wire write_enable;
wire [BITS-1 : 0]  data_write;
wire w;
wire [1:0] sel;

assign write_enable = w ? 1 : we ;
assign data_write = w ? data_r : data_w;

always @(*) begin
	case(sel)
		0: begin
			address_read = address_r;
			address_write = address_w;
		end 

		1: begin
			address_read = address_A;
			address_write = 0;
		end 

		2: begin
			address_read = address_B;
			address_write = address_A;			
		end 

		3: begin
			address_read = 0;
			address_write = address_B;			
		end 

		default: begin
			address_read = address_r;
			address_write = address_w;
		end  
	endcase
end


reg_file #(.N(N) , .BITS(BITS)) RF(
	.clk(clk),
	.address_w(address_write),
	.we(write_enable),
	.data_w(data_write),
	.address_r(address_read),
	.data_r(data_r)
	);

swapper_fsm FSM(
	.clk(clk),
	.reset_n(reset_n),
	.swap(swap),
	.w(w),
	.sel(sel)
	);









endmodule
