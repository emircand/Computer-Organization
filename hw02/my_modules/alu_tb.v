`timescale 1ns / 1ps

module alu_tb;

// Testbench-scope signal declarations
reg clk;
reg reset;
reg start;
reg [31:0] a;
reg [31:0] b;
reg [2:0] aluop;
wire [31:0] result;
wire done;
wire carry;

// Instantiate the ALU module
alu alu_ins(
    .clk(clk),
    .reset(reset),
    .start(start),
    .a(a),
    .b(b),
    .aluop(aluop),
    .res(result),
    .done(done),
	.carry(carry)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Generate a clock with period of 10ns
end

// Test sequence
initial begin
	reset = 1;
	start = 0;
	a = 0;
	b = 0;
	aluop = 3'b000;
	#10; // Wait for reset

	reset = 0; // Release reset

	// Test AND operation
	a = 32'hFFAADD16;
	b = 32'hABCD0012;
	aluop = 3'b000; // AND operation code
	#10; // Wait for operation to complete
	$display("aluop: %b, a: %b, b: %b ; AND Actual Result: %b, Expected Result: %b", aluop, a, b, result, (a & b));

	// Test OR operation
	a = 32'hFFAADD16;
	b = 32'hABCD0012;
	aluop = 3'b001; // OR operation code
	#10; // Wait for operation to complete
	$display("aluop: %b, a: %b, b: %b ; OR Actual Result: %b, Expected Result: %b", aluop, a, b, result, (a | b));

	// Test XOR operation
	a = 32'hFFAADD16;
	b = 32'hABCD0012;
	aluop = 3'b010; // XOR operation code
	#10; // Wait for operation to complete
	$display("aluop: %b, a: %b, b: %b ; XOR Actual Result: %b, Expected Result: %b", aluop, a, b, result, (a ^ b));

	// Test NOR operation
	a = 32'hFFAADD16;
	b = 32'hABCD0012;
	aluop = 3'b011; // NOR operation code
	#10; // Wait for operation to complete
	$display("aluop: %b, a: %b, b: %b ; NOR Actual Result: %b, Expected Result: %b", aluop, a, b, result, ~(a | b));


	// Test LT operation (a < b)
	a = 32'hABCD0012;
	b = 32'hFFAADD16;
	aluop = 3'b100; // LT operation code
	#10; // Wait for operation to complete
	$display("aluop: %b, a: %d, b: %d ; Less Than Actual Result: %b, Expected Result: %b", aluop, a, b, result, a < b);

	// Test LT operation (b < a)
	a = 32'hFFAADD16;
	b = 32'hABCD0012;
	aluop = 3'b100; // LT operation code
	#10; // Wait for operation to complete
	$display("aluop: %b, a: %d, b: %d ; Less Than Actual Result: %b, Expected Result: %b", aluop, a, b, result, a < b);

		
	// Test add operation
	a = 32'hFFAADD16;
	b = 32'hABCD0012;
	aluop = 3'b101; // add operation code
	#10; // Wait for operation to complete
	$display("aluop: %b, a: %d, b: %d ; ADD Actual Result: %d, Expected Result: %d", aluop, a, b, result, a + b);
		
	// Test sub operation
	a = 32'hFFAADD16;
	b = 32'hABCD0012;
	aluop = 3'b110; // sub operation code
	#10; // Wait for operation to complete-
	$display("aluop: %b, a: %d, b: %d ; SUB Actual Result: %d, Expected Result: %d", aluop, a, b, result, a - b);
		
	// Test mod operation
	//a = 32'hFFAADD16;
	//b = 32'hABCD0012;
	a = 22;
	b = 6;
	aluop = 3'b111; // mod operation code
	#10; // Wait for operation to complete
	start = 1; // Start the operation
	// Wait for the operation to complete
	wait(done == 1);
	start = 0; // Stop the operation
	$display("aluop: %b, a: %d, b: %d ; MOD Actual Result: %d, Expected Result: %d", aluop, a, b, result, a % b);

	// Finish the test
	//#100 $finish;
end

endmodule
