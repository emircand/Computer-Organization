module zero_bit_module(
	output zero_bit,
	input [31:0] sub_res
);

wire [31:0] nor_res, and_res;

nor_operation nor_op(
	.a(32'b0),
	.b(sub_res),
	.res(nor_res)
);

// sorry i could not find any other way to do this
assign zero_bit = &nor_res;

endmodule

