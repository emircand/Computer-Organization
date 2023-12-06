module mod(
    input clk,
    input reset,
    input start,
    input [31:0] a,
    input [31:0] b,
    output [31:0] result,
    output done
);

// Wires to connect the control unit and datapath
wire load_a;
wire subtract;
wire is_less_than_b;
wire [31:0] temp;

// Instantiate the control unit
mod_cu control_unit(
  .clk(clk),
  .reset(reset),
  .start(start),
  .is_less_than_b(is_less_than_b),
  .load_a(load_a),
  .subtract(subtract),
  .done(done)
);

// Instantiate the datapath
mod_dp datapath(
  .clk(clk),
  .reset(reset),
  .a(a),
  .b(b),
  .load_a(load_a),
  .subtract(subtract),
  .temp(temp),
  .is_less_than_b(is_less_than_b)
);

// Connect the result of the datapath to the output
assign result = temp;

endmodule
