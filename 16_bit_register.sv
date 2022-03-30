module reg_16 (input  logic Clk, reset, load,
              input  logic [15:0]  data_in,
              output logic [15:0]  data_out);
				  
    //assign Shift_Out = Data_Out[0];
	 
    always_ff @ (posedge Clk)
    begin
	 	 if (reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  data_out <= 16'b0;
		 else if (load)
			  data_out <= data_in;
//		 else if (Shift_En)
//		 begin
//			  //concatenate shifted in data to the previous left-most 3 bits
//			  //note this works because we are in always_ff procedure block
//			  Data_Out <= { Shift_In, Data_Out[15:1] }; 
//	    end
    end
endmodule

module reg_1 (input  logic Clk, reset, load,
              input  logic data_in,
              output logic data_out);
				  
    //assign Shift_Out = Data_Out[0];
	 
    always_ff @ (posedge Clk)
    begin
	 	 if (reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  data_out <= 1'b0;
		 else if (load)
			  data_out <= data_in;
    end
endmodule

module mux16out( input logic [1:0] select,
					input logic [15:0] data0,data1,data2,data3,
					output logic [15:0] mux_out

);
	always_comb
	begin
		unique case (select)
			(2'b00):
				mux_out = data0;
			(2'b01):
				mux_out = data1;
			(2'b10):
				mux_out = data2;
			(2'b11):
				mux_out = data3;
				
			endcase
			
	end
endmodule		

module mux2to1( input logic select,
					input logic [15:0] data0,data1,
					output logic [15:0] mux_out
					);
	always_comb
	begin
			unique case(select)
				(1'b0):
					mux_out = data0;
				(1'b1):
					mux_out = data1;
				endcase
			end
endmodule

module mux21_out3 (input logic select,
						input logic[2:0] data0,data1,
						output logic [2:0] mux_out
						);
always_comb
	begin
			unique case(select)
				(1'b0):
					mux_out = data0;
				(1'b1):
					mux_out = data1;
				endcase
			end
endmodule			

//// creating an ADDR2mux
//// input 0 = IR 10:0 sext
//// input 1 = IR 8:0 sext
//// input 2 = IR 5:0 sext			
//module Adder2mux( input logic select[1:0],
//					input logic [15:0] data0,data1,data2
//					output logic [15:0] mux_out
//					);
//	always_comb
//	begin
//			unique case(select)
//				(2'b00):
//					mux_out = data0;
//				(2'b01):
//					mux_out = data1;
//				(2'b10):
//					mux_out = data2;
//				(2'b11)
//					mux_out = 16'h0000;
//				endcase
//			end
//endmodule
//				
//module addr1mux(input logic select,
//					input logic [15:0], data0,data1
//					output logic [15:0] mux_out
//					);
//		always_comb
//		begin
//				unique case(select)
//					(1'b0):
//						mux_out = data0;
//					(1'b1):
//						mux_out = data1;
//					endcase
//				end
//endmodule
//
//
//			
//			
//			

module dynamic21mux
	#(parameter width = 16)
				( 	input logic select,
					input logic [width-1:0] data0, data1,
					output logic [width-1:0] out
					);
		always_comb
			begin 
				unique case (select)
					(1'b0):
						out = data0;
					(1'b1):
						out = data1;
				endcase
			end
endmodule

module dynamic41mux
	#(parameter width = 16)
			(input logic [1:0] select,
			input logic [width-1:0] data0,data1,data2,data3,
			output logic [width-1:0] out
			);
		always_comb
		begin
			unique case (select)
				(2'b00):
					out = data0;
				(2'b01):
					out = data1;
				(2'b10):
					out = data2;
				(2'b11):
					out = data3;
				endcase
			end
endmodule
					

					