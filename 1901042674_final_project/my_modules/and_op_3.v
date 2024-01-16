module and_op_3(
	input [31:0] a,
	input s0, s1, s2,
   output [31:0] result,
	output out
);

and and1[31:0](out, a, s2, s1, s0);

endmodule
