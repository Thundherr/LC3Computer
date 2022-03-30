module BEN (
	input logic Clk,
	input logic [15:0] data, // comes from bus
	input logic LD_CC, LD_BEN, // comes from control unit
	input logic [2:0] ir_input,
	output logic out
	
	);
	logic n,z,p, n_out, z_out, p_out; // we need a n,z,p input and output 
	logic ben_logic ;
	
	always_ff @ (posedge Clk) 
	begin
		if(LD_CC) // if we load CC register
			begin
			n_out <= n;
			z_out <= z;
			p_out <= p;
			end
		if(LD_BEN) // loading BEN
			begin
			out <= ben_logic; // executes below logic
			end
		
	end
	
	always_comb 
	begin
		ben_logic = (ir_input[2] & n_out) | (ir_input[1] & z_out) | (ir_input[0] & p_out); //ir_input (IR[11:9] concat with nzp)
		
		if(data == 16'h0000) // if zeros we set zero on 
		begin
			n = 1'b0;
			z = 1'b1;
			p = 1'b0;
		end
		else if (data[15] == 1) // if most significant bit is one we have zero
		begin
			n = 1'b1;
			z = 1'b0;
			p = 1'b0;
		end
		else // else we have a pos number
		begin
			n = 1'b0;
			z = 1'b0;
			p = 1'b1;
		end
	end
	
endmodule
