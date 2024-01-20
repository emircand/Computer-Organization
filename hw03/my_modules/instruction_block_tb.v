`define DELAY 10
module instruction_block_tb();
	reg [31:0] pc;
	wire [31:0] instruction;

	instruction_block im(pc, instruction);

	initial begin
	im.instructions_mem[0] = 32'hFFFF;
	im.instructions_mem[1] = 32'h00FF;
	im.instructions_mem[2] = 32'hAAAA;

			  pc = 32'h00000000;
	#`DELAY pc = 32'h00000001;
	#`DELAY pc = 32'h00000002;

	end



	initial begin
	$monitor("Time        : %2d\nRead Address: %32b\nInstruction : %32b\n", 
				$time, pc, instruction);
	end

endmodule 
