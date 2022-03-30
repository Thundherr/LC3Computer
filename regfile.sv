module regfile(
	input logic Clk,Reset,LDREG,
	input logic [15:0] bus,
	input logic [2:0] sr1,sr2,dr,
	output logic [15:0] sr1out,sr2out
);

logic [15:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7;


always_ff @ (posedge Clk) 
	begin
		if(Reset) begin // clear all the registers
			reg0 <= 16'h0000;
			reg1 <= 16'h0000;
			reg2 <= 16'h0000;
			reg3 <= 16'h0000;
			reg4 <= 16'h0000;
			reg5 <= 16'h0000;
			reg6 <= 16'h0000;
			reg7 <= 16'h0000;
	end
	else if (LDREG) 
	begin
		unique case (dr) // input from bus into the right register
			(3'b000):
				reg0 <=bus;
			(3'b001):
				reg1 <=bus;
			(3'b010):
				reg2 <=bus;
			(3'b011):
				reg3 <=bus;
			(3'b100):
				reg4 <=bus;
			(3'b101):
				reg5 <=bus;
			(3'b110):
				reg6 <=bus;
			(3'b111):
				reg7 <=bus;
			endcase
	end
end

always_comb 
begin
	unique case (sr1) // loading into source register 1
			(3'b000):
				sr1out <=reg0;
			(3'b001):
				sr1out <=reg1;
			(3'b010):
				sr1out <=reg2;
			(3'b011):
				sr1out <=reg3;
			(3'b100):
				sr1out <=reg4;
			(3'b101):
				sr1out <=reg5;
			(3'b110):
				sr1out <=reg6;
			(3'b111):
				sr1out <=reg7;
	endcase
	unique case (sr2) // loading into source register 
			(3'b000):
				sr2out <=reg0;
			(3'b001):
				sr2out <=reg1;
			(3'b010):
				sr2out <=reg2;
			(3'b011):
				sr2out <=reg3;
			(3'b100):
				sr2out <=reg4;
			(3'b101):
				sr2out <=reg5;
			(3'b110):
				sr2out <=reg6;
			(3'b111):
				sr2out <=reg7;
		endcase
end
endmodule
