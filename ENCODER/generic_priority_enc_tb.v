module generic_priority_enc_tb();

localparam N = 4;
localparam OUTPUT_SIZE = $clog2(N);

input [INPUT_SIZE-1:0] w;
output reg [OUTPUT_SIZE-1:0] y;
output z;
integer i;

repeat(100) begin
	w = $random;
	#10;
end

endmodule