`timescale 10ns/1ns
module general_mux_tb();
parameter NUM_INPUTS = 5;
parameter WIDTH = 4;
localparam NUM_SELECTORS = $clog2(NUM_INPUTS);
reg [NUM_INPUTS*WIDTH-1:0] w;
reg [NUM_SELECTORS-1:0] sel;
wire [WIDTH-1:0] out;
integer i;

general_mux #(NUM_INPUTS , WIDTH) dut(w,sel,out);
initial
begin
	for(i = 0;i<100;i=i+1)
	begin
	    w = $random;
	    sel = $random;
	    #5;
	end
end

endmodule