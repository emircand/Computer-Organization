module mod_cu(
    input clk,
    input reset,
    input start,
    input is_less_than_b, // Flag from the datapath indicating TEMP < B
    output reg load_a,    // Signal to load A into TEMP
    output reg subtract,  // Signal to perform subtraction TEMP = TEMP - B
    output reg done       // Signal indicating the modulus operation is complete
);

// Define the states
localparam IDLE = 2'b00, LOAD = 2'b01, SUBTRACT = 2'b10, CHECK = 2'b11;
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
  if (reset) 
		state <= IDLE;
  else 
		state <= next_state;
end

// Next state logic
always @(*) begin
  case (state)
		IDLE: // When idle, if 'start' is asserted, move to LOAD state
			 next_state = start ? LOAD : IDLE;

		LOAD: // After loading, move to SUBTRACT state to perform subtraction
			 next_state = SUBTRACT;

		SUBTRACT: // After subtraction, move to CHECK state
			 next_state = CHECK;

		CHECK: // If result is less than B, we are done, otherwise subtract again
			 next_state = is_less_than_b ? IDLE : SUBTRACT;

		default: // Default case to handle undefined states
			 next_state = IDLE;
  endcase
end

// Output logic based on current state
always @(*) begin
  // Default outputs
  load_a = 1'b0;
  subtract = 1'b0;
  done = 1'b0;

  case (state)
		IDLE: begin
			 // In IDLE state, we're not done yet
			 done = 1'b0;
		end
		LOAD: begin
			 // In LOAD state, signal to load A into TEMP
			 load_a = 1'b1;
		end
		SUBTRACT: begin
			 // In SUBTRACT state, signal to perform subtraction
			 subtract = 1'b1;
		end
		CHECK: begin
			 // In CHECK state, if result is less than B, signal that we're done
			 done = is_less_than_b;
		end
  endcase
end

endmodule
