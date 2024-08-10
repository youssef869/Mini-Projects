module general_dec_tb();
parameter INPUT_WIDTH = 2;
localparam OUTPUT_WIDTH = 2**INPUT_WIDTH;

reg [INPUT_WIDTH-1:0] w;
reg en;
wire [0:OUTPUT_WIDTH-1] y;
integer i;

general_dec #(.INPUT_WIDTH(INPUT_WIDTH)) dut(w,en,y);

initial 
begin
	en = 0;
	for(i = 0;i<10;i=i+1)
	begin
		w=$random;
		#10;
	end
	en = 1;

	for(i = 0;i<90;i=i+1)
	begin
		w=$random;
		#10;
	end

end
endmodule