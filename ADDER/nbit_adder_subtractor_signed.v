//modification is done by including overflow indicator that indicates result is correct/wrong
//if overflow bit = 1 that means that overflow occurs and result is wrong , if it's zero so result is correct and no overflow occured
//overflow occurs when you add +ve and +ve and get -ve result or when you add -ve and -ve and get +ve result

module adder_subtractor_signed_dut(x,y,add_n,overflow,result,cout);
parameter WIDTH = 4;
input[WIDTH-1:0] x,y;
input add_n; //if it's 1 subtraction is performed , if it's zero addition is performed 
output [WIDTH-1:0] result;
output cout;
output overflow;
wire [WIDTH-1:0] operand2;

generate
	genvar i;
	for(i = 0;i<WIDTH;i=i+1)
		assign operand2[i] = y[i] ^ add_n;
endgenerate
rca_nbit #(.n(WIDTH)) adder(.a(x),.b(operand2),.cin(add_n),.sum(result),.cout(cout));

assign overflow = (x[WIDTH-1] & operand2[WIDTH-1] & ~result[WIDTH-1] ) | (~x[WIDTH-1] & ~operand2[WIDTH-1] & result[WIDTH-1]);


endmodule