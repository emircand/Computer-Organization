module sub_32(
	input [31:0] a, b,
	output [31:0] result,
	output overflow
);

wire [31:0] inverse_b;
wire cout;

// Taking inverse of b
not_32 not32(.res(inverse_b), .a(b));

// Using 32 bit adder with value1 + (value2' + 1)
adder add32(.a(a), .b(inverse_b), .sum(result), .cout(cout), .cin(1'b1), .overflow(overflow));


endmodule
