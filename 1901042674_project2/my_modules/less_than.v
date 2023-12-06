module less_than(
    input [31:0] a,
    input [31:0] b,
    output res // This will be a single bit output
);
 wire [31:0] subtract_result;
 wire [31:0] b_negated;
 wire subtract_cout;

 // Negate b
 not_32 not_(.res(b_negated), .a(b));

 // Perform subtraction a - b using an adder
 // Since we are using the adder for subtractaion, we set cin to 1
 adder subtractor(
	.a(a),
	.b(b_negated),
	.cin(1'b1),
	.sum(subtract_result),
	.cout(subtract_cout)
 );

 // Determine if a < b by examining the MSB of the subtraction result
 // In two's complement, if a < b, the MSB of the result is 1
 wire lt = subtract_result[31]; // MSB is the sign bit in two's complement
 
 // Since we cannot use assign, we use a buffer to assign the result
 buf buf_lt(res, lt);

endmodule
