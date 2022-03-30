module ALU (
	input logic [15:0] A,B,
	input logic [1:0] select,
	output logic [15:0] out
	);

	always_comb 
	begin
		unique case (select)
			(2'b00):
				out = A+B; // first two of opcode are the select
			(2'b01):
				out = A&B; // AND operation computed
			(2'b10):
				out = ~A; // not A
			(2'b11):
				out = A ; // simply pass a thru
		endcase
	end
endmodule
			