`timescale 1ns / 1ps

module adder_tb;

reg signed [31:0] a, b; // Declare the operands as signed
reg cin;
wire signed [31:0] sum; // Declare the sum as signed
wire cout;

// Instantiate the adder
adder my_adder(
  .a(a), 
  .b(b), 
  .cin(cin), 
  .sum(sum), 
  .cout(cout)
);

initial begin
  // Initialize inputs
  a = 0; b = 0; cin = 0;

  // Apply test vectors
  #10; // Wait for 10 ns
  
  // Test vector 1: Simple addition
  a = 32'd15; 
  b = 32'd10; 
  cin = 0;
  #10;
  $display("Time = %t, a = %d, b = %d, cin = %b, sum = %d, cout = %b", 
			  $time, a, b, cin, sum, cout);
  
  // Test vector 2: Edge case near maximum positive value
  a = 32'sd1999; 
  b = 32'sd1;
  cin = 0;
  #10;
  $display("Time = %t, a = %d, b = %d, cin = %b, sum = %d, cout = %b", 
			  $time, a, b, cin, sum, cout);

  // Test vector 3: Overflow with negative numbers
  //check this out
  a = -32'sd1;
  b = 32'sd1;
  cin = 0;
  #10;
  $display("Time = %t, a = %d, b = %d, cin = %b, sum = %d, cout = %b", 
			  $time, a, b, cin, sum, cout);

  // Test vector 4: Adding negative and positive numbers
  a = -32'sd2;
  b = 32'sd1;
  cin = 0;
  #10;
  $display("Time = %t, a = %d, b = %d, cin = %b, sum = %d, cout = %b", 
			  $time, a, b, cin, sum, cout);

  // Test vector 5: Large positive and negative numbers
  a = 32'h12345678; 
  b = -32'sd2000000000; // Large negative number
  cin = 0;
  #10;
  $display("Time = %t, a = %h, b = %h, cin = %b, sum = %h, cout = %b", 
			  $time, a, b, cin, sum, cout);

  // Finish the simulation
  //#10 $finish;
end

endmodule
