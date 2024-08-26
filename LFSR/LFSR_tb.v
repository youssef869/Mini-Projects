module LFSR_tb ();

reg clk, rst, enable, out_enable;
reg [7: 0] seed;
wire out, valid;

parameter CLK_PERIOD = 10;
parameter TEST_CASES = 5;

reg [7: 0] seeds [TEST_CASES-1: 0];
reg [7: 0] outputs [TEST_CASES-1: 0];




integer i;

always #(CLK_PERIOD/2) clk = ~clk;

initial begin
	initialize();
	$readmemb("Seeds_b.txt", seeds);
	$readmemb("Expec_Out_b.txt", outputs);

	for(i = 0; i < TEST_CASES; i = i + 1) begin
		do_operation(seeds[i]);
		check_out(outputs[i], i);

	end

	$stop;
end


task initialize ;
 begin
  seed = 'b10010011;
  clk  = 1'b0;
  rst  = 1'b0;
  enable = 1'b0;  
  out_enable = 1'b0;  
 end
endtask


task reset ;
begin
	rst = 1'b1;
	#(CLK_PERIOD);
	rst = 1'b0;
	#(CLK_PERIOD);
	rst = 1'b1;
end
endtask



task do_operation ;
input [7:0] in_seed;
begin
		seed = in_seed;
		reset();
		#(CLK_PERIOD);
		enable = 1'b1;
		#(10*CLK_PERIOD);
		enable = 1'b0;
end
endtask

task check_out ;
input [7:0] expected_out;
input   integer    test_count;

reg [7: 0] lfsr_out;
integer j;

begin
		out_enable = 1'b1;
		@(posedge valid);

		for(j = 0; j < 8; j = j + 1) begin
			#(CLK_PERIOD) lfsr_out[j] = out;
		end

		if(lfsr_out == expected_out) begin
			$display("test case %0d success", test_count);
		end 
		else begin
			$display("test case %0d fail", test_count);
		end 

		out_enable = 1'b0;
end
endtask



LFSR DUT(
clk, rst, enable, out_enable,
seed,
out, valid
);
endmodule