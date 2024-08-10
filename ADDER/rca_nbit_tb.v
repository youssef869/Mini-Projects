//modify time scale
`timescale 10ns/1ns;
module rca_nbit_tb();
//stimulas and response signals declaration
parameter width = 4;
reg [width-1:0]a_tb ,b_tb,sum_ref;
reg cout_ref,cin_tb;
wire [width-1:0]sum_dut;
wire cout_dut;
integer i;

//DUT instantiation
rca_nbit dut(.a(a_tb),.b(b_tb),.cin(cin_tb),.sum(sum_dut),.cout(cout_dut));

//test stimulas generator 
initial
begin
	for(i = 0;i<100;i=i+1)
	begin
		a_tb = $random;
		b_tb = $random;
		cin_tb = $random;
		{cout_ref,sum_ref} = a_tb + b_tb+cin_tb;
		#5;
	end
end
endmodule