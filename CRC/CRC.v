module CRC(

input  wire DATA,
input  wire ACTIVE,
input  wire CLK,
input  wire RST,
output reg  CRC,
output reg  Valid
);

reg [7: 0] LFSR;
reg [3: 0] counter;
wire feedback;
wire counter_done;


//parameter TAPS = 8'b01000100;
parameter SEED = 8'hD8;

integer i;


assign feedback = DATA ^ LFSR[0];
assign counter_done = (counter == 4'd8);

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		LFSR  <= SEED;
		CRC   <= 1'b0;
		Valid <= 1'b0;
	end
	else if (ACTIVE) begin
		LFSR[7] <= feedback;
		LFSR[6] <= feedback ^ LFSR[7];
		LFSR[5] <= LFSR[6];
		LFSR[4] <= LFSR[5];
		LFSR[3] <= LFSR[4];
		LFSR[2] <= feedback ^ LFSR[3];
		LFSR[1] <= LFSR[2];
		LFSR[0] <= LFSR[1];

/////////////// using for loop ///////////////
		/*

		for(i = 6; i >= 0; i = i - 1) begin
			if(TAPS[i] == 1'b1) begin
				LFSR[i] <= LFSR[i+1] ^ feedback;
			end
			else begin
				LFSR[i] <= LFSR[i+1];
			end 
		end
		*/ 
	end

	else if (!counter_done) begin
		{LFSR[6:0], CRC} <= LFSR;
		Valid <= 1'b1;
	end

	else begin
		Valid <= 1'b0;
	end  
end



always @(posedge CLK or negedge RST) begin
	if(~RST) begin
		counter <= 4'b0;
	end 

	else if (~ACTIVE) begin
		counter <= counter + 4'b1;
	end 
end 
endmodule