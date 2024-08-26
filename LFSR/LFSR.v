module LFSR (
input  wire        clk, rst, enable, out_enable,
input  wire [7: 0] seed,
output reg         out, valid
);

parameter TAPS = 8'b10101010;
integer i;

reg [7: 0] lfsr_reg;
wire feedback, nor_res;

assign nor_res  = ~|lfsr_reg[6:0];
assign feedback = lfsr_reg[7] ^ nor_res;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		// reset
		lfsr_reg  <= seed;
		out   <= 1'b0;
		valid <= 1'b0;
	end
	else if (enable) begin
		lfsr_reg[0] <= feedback;
		for(i = 7; i > 0; i = i - 1) begin
			if(TAPS[i] == 1'b1) begin
				lfsr_reg[i] <= lfsr_reg[i-1] ^ feedback;
			end
			else begin
				lfsr_reg[i] <= lfsr_reg[i-1];
			end 
		end
	end

	else if(out_enable) begin
		valid <= 1'b1;
		{lfsr_reg[6: 0], out} <= lfsr_reg;
	end 
end
endmodule