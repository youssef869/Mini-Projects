module rca_nbit(a,b,cin,sum,cout);
parameter n = 4; //default value is 4
input[n-1:0] a,b;
input cin;
output[n-1:0] sum;
output cout;
wire c[n:0];

assign c[0] = cin;

generate
	genvar i;
	for(i = 0;i<n;i=i+1)
	begin
		full_adder fa(.a(a[i]),.b(b[i]),.cin(c[i]),.sum(sum[i]),.cout(c[i+1]));
	end
endgenerate

assign cout = c[n];
endmodule