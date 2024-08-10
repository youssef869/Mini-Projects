module mux4x1_tb();
parameter N = 4;
reg[N-1:0] w0,w1,w2,w3;
reg[1:0] sel;
wire[N-1:0] out;
integer i;
mux4x1 #(5) dut(w0,w1,w2,w3,sel,out);

initial 
begin
	for(i = 0;i<100;i=i+1)
	begin
	    w0 = $random;
	    w1 = $random;
	    w2 = $random;
	    w3 = $random;
	    sel = $random;
	    #50;
	end
end
endmodule