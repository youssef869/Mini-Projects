`timescale 10ns/1ns
module enc_4x2_tb();
reg [3:0] w;
wire [1:0] y;

enc_4x2 DUT(w,y);

initial begin
	w = 4'b0001;
	#1 w = 4'b0010;
	#1 w = 4'b0100;
	#1 w = 4'b1000;
end

endmodule