module adder_subtractor_dut(x,y,add_n,result,cout);
parameter WIDTH = 4;
input[WIDTH-1:0] x,y;
input add_n; //if it's 1 subtraction is performed , if it's zero addition is performed 
output [WIDTH-1:0] result;
output cout;
wire [WIDTH-1:0] operand2;


generate
	genvar i;
	for(i = 0;i<WIDTH;i=i+1)
		assign operand2[i] = y[i] ^ add_n;
endgenerate
rca_nbit #(.n(WIDTH)) adder(.a(x),.b(operand2),.cin(add_n),.sum(result),.cout(cout));
endmodule