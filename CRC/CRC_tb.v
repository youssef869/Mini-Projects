`timescale 1ns/1ps
module CRC_tb();

reg  DATA_tb;
reg  ACTIVE_tb;
reg  CLK_tb;
reg  RST_tb;
wire CRC_tb;
wire Valid_tb;

parameter CLK_PERIOD = 10;
parameter TEST_CASES = 10;
parameter DATA_WIDTH = 8;

reg [DATA_WIDTH-1: 0] DATA_mem      [TEST_CASES-1: 0];
reg [DATA_WIDTH-1: 0] Expec_Out_mem [TEST_CASES-1: 0];

reg [DATA_WIDTH-1: 0] design_out;


integer i;

always #(CLK_PERIOD / 2) CLK_tb = ~CLK_tb;

initial begin
	$dumpfile("CRC.vcd");
	$dumpvars;
	$readmemh("DATA_h.txt", DATA_mem);
	$readmemh("Expec_Out_h.txt", Expec_Out_mem);
	intialization();



	for(i = 0; i < TEST_CASES; i = i + 1) begin
		do_operation(DATA_mem[i]);
		check_out(Expec_Out_mem[i] ,i);
	end
	$stop;
end


task intialization ;
begin
	CLK_tb = 1'b0;
	RST_tb = 1'b0;
	DATA_tb = 1'b0;
	ACTIVE_tb = 1'b0;
end
endtask

task reset ;
begin
	RST_tb = 1'b1;
	#(CLK_PERIOD);
	RST_tb = 1'b0;
	#(CLK_PERIOD);
	RST_tb = 1'b1;
end
endtask

task do_operation ;
input [DATA_WIDTH-1 :0] current_DATA;
integer i;
begin
	reset() ;
	ACTIVE_tb = 1'b1;
	for(i = 0; i < DATA_WIDTH; i = i + 1) begin
		 DATA_tb = current_DATA[i];
		 #(CLK_PERIOD);
	end
	ACTIVE_tb = 1'b0;
end
endtask


task check_out ;
input [7: 0] expected_out;
input integer test_case_count;

integer i;

begin
	ACTIVE_tb = 1'b0;
	@(posedge Valid_tb);
	for(i = 0; i < 8; i = i + 1) begin
		#(CLK_PERIOD) design_out[i] = CRC_tb;
	end

	if(design_out == expected_out) begin
		$display("Test case %0d succeed", test_case_count);
	end

	else begin
		$display("Test case %0d failed", test_case_count);
	end
end 
endtask



CRC DUT(

.DATA(DATA_tb),
.ACTIVE(ACTIVE_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.CRC(CRC_tb),
.Valid(Valid_tb)
);


endmodule