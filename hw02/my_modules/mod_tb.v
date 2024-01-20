`timescale 1ns / 1ps

module mod_tb;

// Inputs to the mod_top module
reg clk;
reg reset; // Changed from rst to reset
reg start;
reg [31:0] A;
reg [31:0] B;

// Outputs from the mod_top module
wire [31:0] result;
wire done;

// Instantiate the mod_top module
mod uut (
  .clk(clk),
  .reset(reset), // Changed from rst to reset
  .start(start),
  .a(A),
  .b(B),
  .done(done),
  .result(result)
);

// Clock generation
initial clk = 0; // Initialize the clock to a known value
always #5 clk = ~clk; // 100MHz clock

// Test sequence
initial begin
  // Initialize inputs
  reset = 1; // Hold reset high initially
  start = 0;
  A = 0;
  B = 0;

  // Apply reset for at least two clock cycles
  #20;
  reset = 0;

  // Test cases
  perform_test(32'd50, 32'd25);
  perform_test(32'd100, 32'd3);
  perform_test(32'd12345, 32'd67);

  $finish; // End the simulation
end

// Perform a single test case
task perform_test;
  input [31:0] test_A;
  input [31:0] test_B;
  begin
	reset_system();
	#10; // Wait for a bit
	A = test_A;
	B = test_B;
	start = 1; // Start the operation

	// Wait for the operation to complete
	wait(done == 1);
	start = 0; // Stop the operation

	// Check if result is correct
	if (result !== 32'bx && result == (A % B)) begin
	 $display("Test case passed: A=%d, B=%d, RESULT=%d (Expected: %d)", A, B, result, (A % B));
	end else begin
	 $display("Error in test case: A=%d, B=%d, Expected RESULT=%d, got RESULT=%d", A, B, (A % B), result);
	end

	// Wait a bit before starting the next test
	#20;
  end
endtask

// Reset the system for the next test case
task reset_system;
  begin
	reset = 1;
	#20; // Hold reset high for at least two clock cycles
	reset = 0;
	#20; // Wait for the system to come out of reset
  end
endtask

endmodule
