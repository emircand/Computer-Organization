module instruction_block(
    input [31:0] pc,
    output reg [31:0] instruction
);

    parameter INSTR_MEM_SIZE = 16;  // Define the size of the instruction memory
    reg [31:0] instructions_mem[0:INSTR_MEM_SIZE-1];  // Memory array for instructions
 
    // so the pc needs to be divided by 4 to get the actual index.
    wire [31:0] index = pc >> 2;

    always @(*) begin
        instruction <= instructions_mem[index];
    end

endmodule
