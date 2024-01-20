module fa(
	input a,
	input b,
	input cin,
	output sum,
	output g,
	output p
);

wire w1;
// Sum is the XOR of the two inputs and the carry-in
xor xor1(p, a, b);       // p is the XOR of a and b (propagate)
xor xor2(sum, p, cin);   // sum is the XOR of p and cin

// Generate is the AND of the two inputs
and and1(g, a, b);       // g is the AND of a and b (generate)
and and2(w1, p, cin);

endmodule
