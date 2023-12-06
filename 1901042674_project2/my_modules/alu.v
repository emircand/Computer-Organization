module alu(
 input clk,
 input reset,
 input start,
 input [31:0] a,
 input [31:0] b,
 input [2:0] aluop,
 output [31:0] res,
 output done,
 output carry
);
// Operation results and flags
wire [31:0] add_res, sub_res, mod_res, and_res, or_res, xor_res, nor_res, b_negated;
wire adder_cout, subtractor_cout, mod_done, lt_res;

adder adder_inst(
  .a(a),
  .b(b),
  .cin(1'b0),
  .sum(add_res),
  .cout(adder_cout)
);

// Instantiate the subtractor (as an adder with b negated and cin = 1)
not_32 not_inst(
  .a(b),
  .res(b_negated)
);


adder subtractor_inst(
  .a(a),
  .b(b_negated),
  .cin(1'b1),
  .sum(sub_res),
  .cout(subtractor_cout)
);

// Instantiate the mod module
mod mod_inst(
  .clk(clk),
  .reset(reset),
  .start(start),
  .a(a),
  .b(b),
  .result(mod_res),
  .done(mod_done)
);

// Logic operations
// AND operation module instance
and_operation and_op(
  .a(a),
  .b(b),
  .res(and_res)
);

// OR operation module instance
or_operation or_op(
  .a(a),
  .b(b),
  .res(or_res)
);

// XOR operation module instance
xor_operation xor_op(
  .a(a),
  .b(b),
  .res(xor_res)
);

// NOR operation module instance
nor_operation nor_op(
  .a(a),
  .b(b),
  .res(nor_res)
);

// Instantiate the less_than module
less_than lt_module(
  .a(a),
  .b(b),
  .res(lt_res)
);

//Instantiate the mux to chose operation with aluop
mux_32_8to1 mux0 (
  .res(res), 
  .a(and_res), 
  .b(or_res),
  .c(xor_res), 
  .d(nor_res), 
  .e(lt_res), 
  .f(add_res), 
  .g(sub_res), 
  .h(mod_res),  
  .aluop(aluop)
);

// Output buffer for the done signal
buf(done, mod_done);
buf(carry, adder_cout); // Output buffer for the carry signal

endmodule
