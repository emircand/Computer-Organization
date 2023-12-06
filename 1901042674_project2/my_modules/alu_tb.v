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
    a = 32'hFFFFFFFF;
    b = 32'b11101;
    aluop = 3'b000; // AND operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; AND Result: %b", a, b, result);

    // Test OR operation
    a = 32'hFFFFFFFF;
    b = 32'b0;
    aluop = 3'b001; // OR operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; OR Result: %b", a, b, result);
	 
	 // Test XOR operation
    a = 32'hFFFFFFFF;
    b = 32'b0;
    aluop = 3'b010; // XOR operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; XOR Result: %b", a, b, result);
	 
	 // Test NOR operation
    a = 32'b0;
    b = 32'b1;
    aluop = 3'b011; // NOR operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; NOR Result: %b", a, b, result);

    // Test LT operation
    a = 32'd15;
    b = 32'd17;
    aluop = 3'b100; // LT operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; lessthan Result: %b", a, b, result);
	 
	 // Test LT operation
    a = 32'd15;
    b = 32'd12;
    aluop = 3'b100; // LT operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; lessthan Result: %b", a, b, result);
	 
	 // Test add operation
    a = 32'b1;
    b = 32'b1;
    aluop = 3'b101; // add operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; add Result: %d", a, b, result);
	 
	 // Test sub operation
    a = 32'd36;
    b = 32'd5;
    aluop = 3'b110; // sub operation code
    #10; // Wait for operation to complete
    $display("a: %d, b: %d ; sub Result: %d", a, b, result);
	 
	 // Test mod operation
    a = 32'd15;
    b = 32'd2;
    aluop = 3'b111; // mod operation code
    #10; // Wait for operation to complete
    start = 1; // Start the operation
	// Wait for the operation to complete
	wait(done == 1);
	start = 0; // Stop the operation
	// Check if result is correct
	if (result == (a % b)) begin
	 $display("Test case passed: A=%d, B=%d, RESULT=%d (Expected: %d)", a, b, result, (a % b));
	 end else begin
	 $display("Error in test case: A=%d, B=%d, Expected RESULT=%d, got RESULT=%d", a, b, (a % b), result);
	end

    // Finish the test
    //#100 $finish;
end

endmodule
