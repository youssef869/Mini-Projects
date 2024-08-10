`timescale 10ns/1ns
module priority_enc_4x2_tb();
reg [3:0] w;
wire[1:0] y;
wire z;

priority_enc_4x2 DUT(.w(w),.y(y),.z(z));

initial begin
	w[3] = 1'b1;
	repeat(20) begin
		w[2] = $random;
		w[1] = $random;
		w[0] = $random;
		#1;
	end 


	w[3] = 1'b0;
	w[2] = 1'b1;
	repeat(20) begin
		w[1] = $random;
		w[0] = $random;
		#1;
	end 




	w[3] = 1'b0;
	w[2] = 1'b0;
	w[1] = 1'b0;

	w[0] = 1'b0;
	#1 w[0] = 1'b1;

	#1;
	w[0] = 0;

end
endmodule