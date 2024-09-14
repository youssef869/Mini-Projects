`timescale 10ns/1ns
module alu_tb();
parameter INPUT_PRIORITY = "A";
parameter FULL_ADDER = "OFF";

reg [2:0] A,B,opcode;
reg cin,serial_in,direction,red_op_A,red_op_B,bypass_A,bypass_B,clk,rst;


wire [5:0] out;
wire [15:0] leds;

alu #(.INPUT_PRIORITY(INPUT_PRIORITY),.FULL_ADDER(FULL_ADDER))
     dut( .A(A) ,.B(B) ,.opcode(opcode) ,.cin(cin) ,.serial_in(serial_in) ,.direction(direction),
     	  .red_op_A(red_op_A) ,.red_op_B(red_op_B) ,.bypass_A(bypass_A) ,.bypass_B(bypass_B), 
     	  .clk(clk) ,.rst(rst) ,.out(out) ,.leds(leds) );

initial begin
	clk = 0;
	forever
		#1 clk = ~clk;
end

initial begin
	////////// testing reset functionality //////////

	rst = 1;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $random;
		cin = $random;
		serial_in = $random;
		direction = $random;
		red_op_A = $random;
		red_op_B = $random;
		bypass_A = $random;
		bypass_B = $random;
		@(negedge clk);
	end

	////////// testing bypass_A functionality //////////

	rst = 0;
	bypass_A = 1;
	bypass_B = 0;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $random;
		cin = $random;
		serial_in = $random;
		direction = $random;
		red_op_A = $random;
		red_op_B = $random;
		@(negedge clk);
	end

	////////// testing bypass_B functionality //////////

	bypass_A = 0;
	bypass_B = 1;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $random;
		cin = $random;
		serial_in = $random;
		direction = $random;
		red_op_A = $random;
		red_op_B = $random;
		@(negedge clk);
	end

	////////// testing the parameter INPUT_PRIORITY functionality //////////

	// it should bypass A in this case 
	bypass_A = 1;
	bypass_B = 1;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $random;
		cin = $random;
		serial_in = $random;
		direction = $random;
		red_op_A = $random;
		red_op_B = $random;
		@(negedge clk);
	end

	////////// testing red_op_A functionality //////////

	bypass_A = 0;
	bypass_B = 0;
	red_op_A = 1;
	red_op_B = 0;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $urandom_range(0,1);
		cin = $random;
		serial_in = $random;
		direction = $random;
		@(negedge clk);
	end

	////////// testing red_op_B functionality //////////

	red_op_A = 0;
	red_op_B = 1;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $urandom_range(0,1);
		cin = $random;
		serial_in = $random;
		direction = $random;
		@(negedge clk);
	end

	////////// testing the functionality of the parameter INPUT_PRIORITY functionality //////////

	red_op_A = 1;
	red_op_B = 1;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $urandom_range(0,1);
		cin = $random;
		serial_in = $random;
		direction = $random;
		@(negedge clk);
	end

	////////// invalid case //////////
	bypass_A = 0;
	bypass_B = 0;
	opcode = 3'b110;
	repeat(20) begin
		A = $random;
		B = $random;
		cin = $random;
		serial_in = $random;
		direction = $random;
		red_op_A = $random;
		red_op_B = $random;
		@(negedge clk);
	end

	////////// invalid case //////////

	opcode = 3'b111;
	repeat(20) begin
		A = $random;
		B = $random;
		cin = $random;
		serial_in = $random;
		direction = $random;
		red_op_A = $random;
		red_op_B = $random;
		bypass_A = $random;
		bypass_B = $random;
		@(negedge clk);
	end

	////////// invalid case //////////
	bypass_A = 0;
	bypass_B = 0;
	red_op_A = 1;
	red_op_B = 1;
	repeat(20) begin
		A = $random;
		B = $random;
		opcode = $urandom_range(2,5);
		cin = $random;
		serial_in = $random;
		direction = $random;
		@(negedge clk);
	end

	////////// Normal operation (and,xor,add,multiply,shift (right and left),rotate(right and left)) //////////
	red_op_A = 0;
	red_op_B = 0;
	repeat(100) begin
		A = $random;
		B = $random;
		opcode = $urandom_range(0,5);
		cin = $random;
		serial_in = $random;
		direction = $random;
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
	end
$stop;
end
endmodule