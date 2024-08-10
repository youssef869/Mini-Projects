//golden model which uses verilog operators
module adder_subtractor_signed_ref
#(parameter WIDTH = 4)
(input [WIDTH-1:0] a,b,
input add_n, //if it's 1 subtraction is performed , if it's zero addition is performed 
output reg overflow,
output reg [WIDTH-1:0] res,
output reg cout);


always @(*) begin
	if(~add_n) begin
		assign {cout,res} = a + b; 
		assign overflow = a & b & ~res | ~a & ~b & res;
	end

	else begin
		assign res = a-b;
	end	
	end

endmodule