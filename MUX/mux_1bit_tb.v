module mux_1bit_tb();
parameter NUM_INPUTS = 5;
reg [NUM_INPUTS-1:0] w;
reg [$clog2(NUM_INPUTS)-1:0] sel;
wire out;

integer i;
mux_1bit #(NUM_INPUTS) dut(w,sel,out);

initial 
begin
	for(i = 0;i<100;i=i+1)
	begin
	    w = $random;
	    sel = $random;
	    #50;
	end
end
endmodule