module cla_8bit(
	output [7:0] sum,
	output cout,
	input [7:0] a, b,
	input cin
);
// Declare internal wires
wire c;
wire [7:0] P, G;

// Instantiate the 4-bit CLA module
cla_4bit cla0(.a(a[3:0]), .b(b[3:0]), .cin(cin), .p(P[3:0]), .g(G[3:0]), .sum(sum[3:0]), .cout(c));
cla_4bit cla1(.a(a[7:4]), .b(b[7:4]), .cin(c), .p(P[7:4]), .g(G[7:4]), .sum(sum[7:4]), .cout(cout));

endmodule