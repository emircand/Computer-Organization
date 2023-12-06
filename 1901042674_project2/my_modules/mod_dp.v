module mod_dp(
    input clk,
    input reset,
    input [31:0] a,
    input [31:0] b,
    input load_a,          // Signal to load A into TEMP
    input subtract,        // Signal to perform subtraction TEMP = TEMP - B
    output reg [31:0] temp,// Temporary register to store the current result
    output is_less_than_b  // Flag indicating TEMP < B
);

// Intermediate wires for the multiplexer outputs
wire [31:0] mux_out1;
wire [31:0] mux_out2;

// !!!change that after implementation of adder!!! 
// For subtraction, prepare the two's complement of B 
wire [31:0] b_twos_complement = subtract ? ~b + 1'b1 : 32'b0;

// Instantiation of a 32-bit 2-to-1 multiplexer
// Assuming mux_out1 selects between 'a' and 'temp' based on 'load_a' signal
assign mux_out1 = load_a ? a : temp;

// !!!change that after implementation of adder!!! 	
// Assuming mux_out2 selects between 'b' and 0 based on 'subtract' signal
// If 'subtract' is high, we want to subtract 'b', otherwise pass 0
//assign mux_out2 = subtract ? b : 32'b0;
// Assign mux_out2 to select between 'b' and 0 based on 'subtract' signal
assign mux_out2 = subtract ? b_twos_complement : 32'b0;

// Instantiation of a 32-bit adder (add32)
// Since this is subtraction, we will invert the bits of 'b' and add one to perform two's complement subtraction
//    wire [31:0] adder_result;
//    add32 adder_inst(
//        .a(mux_out1),
//        .b(~mux_out2),
//        .cin(subtract), // The carry in is high only if we are subtracting, effectively adding 1 to perform two's complement addition
//        .sum(adder_result)
//    );

// Perform the addition or subtraction based on the control signals
// When 'subtract' is high, 'b_twos_complement' is used which is B's two's complement
wire [31:0] adder_result = mux_out1 + mux_out2;

// Register to hold the result of the addition/subtraction
always @(posedge clk or posedge reset) begin
  if (reset) begin
		temp <= 32'b0;
  end else begin
		temp <= adder_result;
  end
end

// Set the flag is_less_than_b
// This is a comparison to see if the 'temp' value is less than 'b'
assign is_less_than_b = (temp < b);

endmodule
