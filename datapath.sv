module datapath(
input logic Clk, Reset,
input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC,
input logic GatePC, GateMDR, GateALU, GateMARMUX,
input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX, MARMUX,MIO_EN,
input logic [1:0] PCMUX, ADDR2MUX, ALUK,
input logic [15:0] MDR_In,
input logic [15:0] MAR, MDR, IR,
output logic [15:0] new_pc, new_mar, new_mdr, new_ir,
output logic ben_out
);

logic [3:0] gate_select;
logic [15:0] bus;
logic [15:0] mio_out;
logic [15:0] pc_in;
logic [15:0] ir_out;
logic [15:0] mdr_out, pc_out, mar_out, alu_out;
logic [15:0] mdrmuxout,sr2muxout, addr1muxout,addr2muxout,pcmuxout;
logic [2:0] drmuxout, sr1muxout;
logic [15:0] sr2out,sr1out;
logic benout;

/* outputs: sr1out, sr2out, ir_out,mdr_out, mar_out,pc_out,
* mdrmux_out, sr2_mux_out, addr1_mux_out,pc_mux_out,mdr_mux_out
* addr2mux_out, alu_out
* regfile_in
*/


always_comb 
	begin
	gate_select = {GatePC, GateMDR, GateALU, GateMARMUX} ;
	bus = 16'b0; // init bus
	case (gate_select)
		4'b1000:
			bus = pc_out;
		4'b0100:
			bus = mdr_out;
		4'b0010:
			bus = alu_out;
		4'b0001:
			bus = addr1muxout + addr2muxout;
	endcase
//	pc_in = 16'b0;
//	unique case (PCMUX)
//		2'b00:
//			pc_in = pc_out + 1;
//		2'b01:
//			pc_in = bus;
//	endcase
	end
	

reg_16 PC_REG ( .Clk(Clk), .reset(Reset),.load(LD_PC), .data_in(pcmuxout),.data_out(pc_out));
reg_16 MDR_REG ( .Clk(Clk), .reset(Reset),.load(LD_MDR),.data_in(mdrmuxout),.data_out(mdr_out));
reg_16 MAR_REG ( .Clk(Clk), .reset(Reset),.load(LD_MAR),.data_in(bus),.data_out(mar_out));
reg_16 IR_REG ( .Clk(Clk),.reset(Reset),.load(LD_IR),.data_in(bus),.data_out(ir_out));

dynamic21mux mdrmux( 
	.select(MIO_EN),
	.data0(bus), // inputs are from bus and mdr
	.data1(MDR_In),//WHERE DOES THIS COME FROM?
	.out(mdrmuxout) // goes into mdr 
	);

dynamic21mux #(3) sr1mux(
	.select(SR1MUX),
	.data0(ir_out[11:9]), // both inouts come from ir bits
	.data1(ir_out[8:6]),
	.out(sr1muxout) // goes into register file
	);

dynamic21mux sr2mux(
	.select(SR2MUX),
	.data0(sr2out), // inputs are ir bits and sr2 from reg file
	.data1({{11{ir_out[4]}},ir_out[4:0]}), // sext the bits
	.out(sr2muxout)
);

dynamic21mux addr1mux(
	.select(ADDR1MUX),
	.data0(pc_out), // inputs from pc_out and sr1out
	.data1(sr1out),
	.out(addr1muxout)
	);


dynamic41mux addr2mux(
	.select(ADDR2MUX),
	.data0(16'h0000), // all zeros
	.data1({{10{ir_out[5]}},ir_out[5:0]}), // sext the bits
	.data2({{7{ir_out[8]}},ir_out[8:0]}),
	.data3({{5{ir_out[10]}},ir_out[10:0]}),
	.out(addr2muxout) //mux output
	);

dynamic21mux #(3) drmux(
	.select(DRMUX),
	.data0(ir_out[11:9]),
	.data1(3'b111),
	.out(drmuxout)
	);

dynamic41mux pcmux(
	.select(PCMUX),
	.data0(pc_out + 1'b1), // incrementing pc
	.data1(bus), 
	.data2(addr1muxout + addr2muxout), // two muxes added together as in datapath
	.data3(),
	.out(pcmuxout)
	);

regfile physRegfile( // has input from three 3bit muxes and one 16 bit input from bus
	.Clk(Clk),
	.Reset(Reset),
	.LDREG(LD_REG),
	.bus(bus),
	.sr1(sr1muxout),
	.sr2(ir_out[2:0]),
	.dr(drmuxout),
	.sr2out(sr2out),
	.sr1out(sr1out)
	);

BEN ben0(
	.Clk(Clk),
	.data(bus), // comes from bus
	.LD_CC(LD_CC), .LD_BEN(LD_BEN), // comes from control unit
	.ir_input(ir_out[11:9]), // ir from datapath figure
	.out(ben_out)
);

ALU alunit(
	.B(sr2muxout),.A(sr1out),
	.select(ALUK),
	.out(alu_out)
);
//// addr1mux
//// inputs: SR1 out and PC_out
//mux2to1 physADDR1MUX(.select(ADDR1MUX),.data0(pc_out),.data1(sr1_out),.mux_out(addr1_wire)); 
//// SR2muc
////inputs: sign extended IR[4:0], sr2_out
//mux2to1 physSR2MUX(.select(SR2MUX),.data0(/*sign extendeded IR*/),.data1(sr2_out),.mux_out(sr2_wire));
//
////DRMux
//// inputs: 111, IR[11:9]
////select: DRMUX
//mux2to1_out3 physDRMUX(.select(DRMUX),.data0(3'b111), .data1(ir_out[11:9]),.mux_out(dr_mux_wire));
//
//
//// SR1mux
//// inputs: IR[11;9] 
//// select: SR1MUX
//mux2to1 physSR1MUX(.select(SR1MUX),.data0(ir_out[11:9]),.data1(ir_out[8:6]),.mux_out(sr1_wire));
//
////ADDR2mux
///* INPUTS: 
//* data0: SEXT IR[10;0]
//* data1: SEXT IR[8:0]
//* data2: SEXT IR[5:0]
//* SELECT: ADDR2MUX
//* output: addr2_wire
//*/
//mux16out physADDR2MUX(.select(ADDR2MUX),.data0(),.data1(),.data2(),.mux_out(addr2_wire));
//
////Adder2mux ADD2_MUX( .Clk(clk), .reset(Reset), .select(ADDR2MUX),
////.data0(ir_out[10:0]),data1(ir_out[8:0]), .data2(ir_out[5:0]),
////.data_out(addr2_output)
////);
////
////Addr1mux ADD1_MUX( .clk(clk), .reset(Reset),
//// .select(ADDR1MUX), .data0(pc_out), .data1(SR1OUT)
//// ); // still need a register file
////
///* PC MUX
//* INPUTS: 
//* data0 = bus[15:0]
//* data1 = addr1_wire + addr2_wire
//* data2 = pc_reg + 1
//* SELEXt: PCMUX
//*/
//pc_mux physPCMUX(.clk(clk), .reset(Reset), .select(PCMUX),.data0(bus),.data1(addr2_wire+ addr1_wire), .data2(PC_REG+1));



assign new_mar = mar_out;
assign new_mdr = mdr_out;
assign new_pc = pc_out;
assign new_ir = ir_out;
//assign ben_out_logic = benout;


//assign HEX0 = ir_out[3:0];
//assign HEX1 = ir_out[7:4];
//assign HEX2 = ir_out[11:8];
//assign HEX3 = ir_out[15:12];


endmodule
