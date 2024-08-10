module dec2x4_en_tb();
reg [1:0] w;
reg en;
wire [0:3] y;
integer i;

dec2x4_en dut(w,en,y);

initial 
begin
    en = 0;
	for(i = 0;i<100;i=i+1)
	begin
		w = $random;
		#10;
	end
	en = 1;
	for(i = 0;i<900;i=i+1)
	begin
		w = $random;
		#10;
	end
end
endmodule