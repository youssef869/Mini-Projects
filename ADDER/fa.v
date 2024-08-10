module full_adder(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
wire ha_out,c1,c2;
half_adder ha1(.a(a),.b(b),.sum(ha_out),.cout(c1));
half_adder ha2(.a(ha_out),.b(cin),.sum(sum),.cout(c2));
assign cout = c1|c2;
endmodule