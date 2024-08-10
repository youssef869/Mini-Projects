module adder_subtractor_ref(x,y,control,result,cout);
parameter WIDTH = 4;
input[WIDTH-1:0] x,y;
input control; //if it's 1 subtraction is performed , if it's zero addition is performed 
output reg [WIDTH-1:0] result;
output reg cout;
always @(*) begin
	if(control == 0)
	{cout , result} = x+y;
	else 
	//carry out is meaningless while doing subtraction
	result = x-y;
end
endmodule