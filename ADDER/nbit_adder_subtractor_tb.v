`timescale 10ns/1ns
//randomized test
module adder_subtractor_tb();
parameter WIDTH = 4;
reg [WIDTH-1:0] x_tb,y_tb;
reg control_tb; //if it's 1 subtraction is performed , if it's zero addition is performed 
wire [WIDTH-1:0] result_dut , result_ref;
wire cout_dut,cout_ref;
integer i;

adder_subtractor_dut dut(x_tb,y_tb,control_tb,result_dut,cout_dut);
adder_subtractor_ref ref(x_tb,y_tb,control_tb,result_ref,cout_ref);
initial
begin
	for(i=0;i<100;i=i+1)
	begin
		x_tb = $random;
		y_tb = $random;
		control_tb = $random;
		#5;
		if((result_dut != result_ref) || (cout_dut != cout_ref))
		    $display("Error .. output from reference not equal to output from DUT.");
	end
end

endmodule