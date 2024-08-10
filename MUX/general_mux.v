//mux with general number of inputs and general size for each of them
module general_mux(w,sel,out);
parameter NUM_INPUTS = 5;
parameter WIDTH = 4;
localparam NUM_SELECTORS = $clog2(NUM_INPUTS);
input [NUM_INPUTS*WIDTH-1:0] w;
input [NUM_SELECTORS-1:0] sel;
output [WIDTH-1:0] out;

assign out = (sel <= NUM_INPUTS - 1) ? w[sel*WIDTH +: WIDTH] : 'bx ; // equivalent to [3+sel*4:sel*4] but we used variable part select

endmodule