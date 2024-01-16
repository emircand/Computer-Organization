module alu(
  input [31:0] alu_src1,
  input [31:0] alu_src2,
  input [2:0] alu_ctr,
  output [31:0] alu_result,
  output zero_bit 
);
// Operation results and flags
wire [31:0] add_res, sub_res, and_res, 
  or_res, xor_res, nor_res, b_negated, mod_res;
wire adder_cout, subtractor_cout, lt_res, done;

adder adder_inst(
  .a(alu_src1),
  .b(alu_src2),
  .cin(1'b0),
  .sum(add_res),
  .cout(adder_cout)
);

// Instantiate the subtractor (as an adder with b negated and cin = 1)
not_32 not_inst(
  .a(alu_src2),
  .res(b_negated)
);

adder subtractor_inst(
  .a(alu_src1),
  .b(b_negated),
  .cin(1'b1),
  .sum(sub_res),
  .cout(subtractor_cout)
);

// Logic operations
// AND operation module instance
and_operation and_op(
  .a(alu_src1),
  .b(alu_src2),
  .res(and_res)
);

// OR operation module instance
or_operation or_op(
  .a(alu_src1),
  .b(alu_src2),
  .res(or_res)
);

// XOR operation module instance
xor_operation xor_op(
  .a(alu_src1),
  .b(alu_src2),
  .res(xor_res)
);

// NOR operation module instance
nor_operation nor_op(
  .a(alu_src1),
  .b(alu_src2),
  .res(nor_res)
);

// Instantiate the less_than module
less_than lt_module(
  .a(alu_src1),
  .b(alu_src2),
  .res(lt_res)
);

//Instantiate the mux to chose operation with aluop
mux_32_8to1 mux0 (
  .res(alu_result), 
  .a(and_res), 
  .b(or_res),
  .c(xor_res), 
  .d(nor_res), 
  .e(lt_res), 
  .f(add_res), 
  .g(sub_res),
  .h(mod_res),  
  .aluop(alu_ctr)
);

wire [31:0] zero_bit_wire;
// Comparator to check if sub_res is zero
nor_operation nor_zero(
  .a(32'b0),
  .b(sub_res),
  .res(zero_bit_wire)
);

buf buf_zero_bit(zero_bit, zero_bit_wire[0]);

endmodule
