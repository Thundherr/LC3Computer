module testbenchlab5();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
//logic Clk = 0;
//logic Reset, Run, Continue;
//logic [15:0] SW;
//logic [9:0] LED;
//logic [15:0] PC_REG,MAR_REG,IR_REG,MDR_REG;
//
//logic [6:0] HEX0, HEX1,
//		 HEX2,
//		 HEX3; 
//logic OE, WE;

logic [9:0] SW;
logic	Clk, Run, Continue;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic [15:0] MDR, MAR, PC, IR;
				
// A counter to count the instances where simulation results
// do no match with expected results
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
slc3_testtop SLC3_TESTTOP(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
Run = 1;		// Toggle Rest
Continue =1;

#2 Run = 0;
Continue = 0;

#2 Run = 1;
Continue = 1;

#4;
#2 Run = 0;
#2 Run = 1;

#10 Continue = 1;
#4;
SW = 16'h005A;

#100 SW = 16'h0001;
#10 Continue = 0;
#10 Continue = 1;



#100 SW= 16'h0001;
#10 Continue = 0;
#10 Continue = 1;

#100 SW= 16'h0002;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h0003;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h0004;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h0005;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h0006;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h0007;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h0008;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h0009;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h000A;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h000B;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h000C;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h000D;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h000E;
#10 Continue = 0;
#10 Continue = 1;

#100;

#100 SW= 16'h000F;
#10 Continue = 0;
#10 Continue = 1;

#100 SW= 16'h0010;
#10 Continue = 0;
#10 Continue = 1;


#100;

#100;


#100 SW = 16'h0002;
  Continue = 0;
#10 Continue = 1;
#21000 SW = 16'h0003;

#400 Continue = 0;
#10 Continue = 1;

#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#200 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#200 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;
#300 Continue = 0;
#10 Continue = 1;

//SW = 16'h0031;
//#150 SW = 16'h0005;
//Continue = 0;
//#10 Continue = 1;
//#150 SW = 16'h0020;
//Continue = 0;
//#10 Continue = 1;



// xor TEST
//SW = 16'h0014;
//#100 SW = 16'h000F;
//Continue = 0;
//#10 Continue = 1;
//#100 SW = 16'h00F0;
//#10 Continue = 0;
//#10 Continue = 1;
//
//#200 
//#10 Continue = 0;
//#10 Continue = 1;




/*

#2 Continue = 1;
#2 Continue = 0; 
#2 Continue = 1;

#2 Run = 1;
#2 Run = 0;// starts program
#2 Run = 1;

#100;

*/
//#2 SW = 16'h000B; // first test case from handout and set the value from the switchs
//
//#2 Continue = 1;
//#2 Continue = 0; 
//#2 Continue = 1;
//
//#2 Run = 1;
//#2 Run = 0;// starts program
//#2 Run = 1;
//
//#100;
//#2 Continue = 1;
//#2 Continue = 0; 
//#2 Continue = 1;
//
//#100
//#2 Continue = 1;
//#2 Continue = 0; 
//#2 Continue = 1;
//
//#100
//#2 Continue = 1;
//#2 Continue = 0; 
//#2 Continue = 1;
//
//#100
//#2 Continue = 1;
//#2 Continue = 0; 
//#2 Continue = 1; // 4 contained in the LEDs

//
//#200; // delay 
//#2 Continue = 1;
//#2 Continue = 0; 
//#2 Continue = 1;
//
//#200 SW = 16'h0000; // force it zero
//
//#200 SW = 16'h0001; // force it to one
//
//#200
//#2 Continue = 1;
//#2 Continue = 0; 
//#2 Continue = 1;

//#2 SW = 16'h000B;
//#100 Continue = 1;
//#10 Continue = 0;
//#10 Continue = 1;
//#10 Continue = 0;
//#10 Continue = 1; //should only increment on continue
//#10 Continue = 0;
//#10 Continue = 1; //should only increment on continue











	
//
//#2 Run = 0;
//#2 Run = 1; 
//#2 Continue = 0;
//
//#150 SW = 16'h1111;
//#2 Run = 0;
//#2 Run = 1;
//
//#150 SW = 16'h0001;
//#2 Run = 0;
//#2 Run = 1;
//



end
endmodule
