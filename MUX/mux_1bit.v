module mux_1bit(w,sel,out);
parameter NUM_INPUTS = 2;
localparam NUM_SELECTORS = $clog2(NUM_INPUTS);
input [NUM_INPUTS-1:0] w;
input [NUM_SELECTORS-1:0] sel;
output out;

assign out = (sel <= NUM_INPUTS - 1) ? w[sel] : 'bx ;

endmodule