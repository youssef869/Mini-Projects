module modulus_counter
#(parameter FINAL_VALUE = 9,
  localparam SIZE = $clog2(FINAL_VALUE)
 )
 (
	input clk,
	input enable,
	input reset_n,
	output [SIZE-1 : 0] count
 );



reg [SIZE-1 : 0] cs,ns;
wire done;

assign done = (cs == FINAL_VALUE);

//state memory
always @(posedge clk or negedge reset_n) begin
	if(~reset_n)
		cs <= 0;
	else if(enable)
		cs <= ns;
end

//next state logic
always @(*) begin
	ns = done ? 0 : cs + 1;
end

//output logic 
assign count = cs;

endmodule