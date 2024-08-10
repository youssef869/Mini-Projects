module alsu(A,B,opcode,cin,serial_in,direction,red_op_A,red_op_B,bypass_A,bypass_B,clk,rst,out,leds);
parameter INPUT_PRIORITY = "A";
parameter FULL_ADDER = "ON";

input [2:0] A,B,opcode;
input cin,serial_in,direction,red_op_A,red_op_B,bypass_A,bypass_B,clk,rst;

reg [2:0] A_reg,B_reg,opcode_reg;
reg cin_reg,serial_in_reg,direction_reg,red_op_A_reg,red_op_B_reg,bypass_A_reg,bypass_B_reg;

output reg [5:0] out;
output reg [15:0] leds;


always @(posedge clk or posedge rst) begin
	if (rst) begin
		// reset
		A_reg         <= 0;
		B_reg         <= 0;
		opcode_reg    <= 0;
		cin_reg       <= 0;
		serial_in_reg <= 0;
		direction_reg <= 0;
		red_op_A_reg  <= 0;
		red_op_B_reg  <= 0;
		bypass_A_reg  <= 0;
		bypass_B_reg  <= 0;
	end
	else begin
		A_reg         <= A;
		B_reg         <= B;
		opcode_reg    <= opcode;
		cin_reg       <= cin;
		serial_in_reg <= serial_in;
		direction_reg <= direction;
		red_op_A_reg  <= red_op_A;
		red_op_B_reg  <= red_op_B;
		bypass_A_reg  <= bypass_A;
		bypass_B_reg  <= bypass_B;
	end
end

always @(posedge clk or posedge rst) begin
	if(rst) begin
		out  <= 0;
		leds <= 0;
	end
	else begin
	//arbitary default values
		leds <= 0;
		out  <= 0;
					   
		if((opcode_reg == 3'b110 || opcode_reg == 3'b111) || 
		   (opcode_reg != 3'b000 && opcode_reg != 3'b001 && (red_op_A_reg || red_op_B_reg)))
			leds <= ~leds;

		if(bypass_A_reg) begin
			if(bypass_B_reg) begin
				if(INPUT_PRIORITY == "A")
					out <= A_reg;
				else if(INPUT_PRIORITY == "B")
					out <= B_reg;
			end
			else
				out <= A_reg;
		end
		else if(bypass_B_reg) begin
			out <= B_reg;
		end

		else begin
			//second invalid case
			if((opcode_reg != 3'b000 && opcode_reg != 3'b001 && (red_op_A_reg || red_op_B_reg))) begin
				out  <= 0;
			end
			else begin
				case(opcode_reg)
					3'b000:begin
						if(red_op_A_reg) begin
							if(red_op_B_reg) begin
								if(INPUT_PRIORITY == "A")
									out <= &A_reg;
								else if(INPUT_PRIORITY == "B")
									out <= &B_reg;
							end
						end
						else if(red_op_B_reg)
							out <= &B_reg;
						else 
							out <= A_reg & B_reg;
						
					end

					3'b001:begin
						if(red_op_A_reg) begin
							if(red_op_B_reg) begin
								if(INPUT_PRIORITY == "A")
									out <= ^A_reg;
								else if(INPUT_PRIORITY == "B")
									out <= ^B_reg;
							end
						end
						else if(red_op_B_reg)
							out <= ^B_reg;
						else  
							out <= A_reg ^ B_reg;
					end

					3'b010: begin
						if (FULL_ADDER == "ON")
							out <= A_reg + B_reg + cin_reg;
						else if(FULL_ADDER == "OFF")
							out <= A_reg + B_reg;
					end

					3'b011: begin 
						out <= A_reg * B_reg;
					end

					3'b100: begin
						if(direction_reg)
						//shift left by 1 bit
							out <= {out[4:0], serial_in_reg}; 
						else
						//shift right by 1 bit
							out <= {serial_in_reg , out[5:1]};
					end

					3'b101: begin
						if(direction_reg)
						//rotate left by 1 bit
							out <= {out[4:0], out[5]}; 
						else
						//rotate right by 1 bit
							out <= {out[0] , out[5:1]};
					end
					default: begin
						out <= 0;
					end
				endcase
			end
		end
	end
end
endmodule