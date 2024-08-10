module mux2x1_tb();
reg[4:0] w0,w1;
reg sel;
wire[4:0] out;
integer i;
mux2x1 #(5) dut(w0,w1,sel,out);

initial 
begin
	for(i = 0;i<100;i=i+1)
	begin
	    w0 = $random;
	    w1 = $random;
	    sel = $random;
	    #50;
	end
end
endmodule