module mips(
    input clock
);  
 
wire [4:0] write_reg, jal_reg;

wire [31:0] read_data, read_data1, read_data2, write_data, alu_src2;
wire regWrite, memWrite, memRead, jump, ALUsrc, move,
	regDst, branch, zero_bit, byteOperations; 
wire [2:0] ALUop, alu_ctr;   

wire [31:0] alu_result, shifted_address, sign_ext_imm, instruction;
reg [31:0] pc, prev_pc;
wire [31:0] pc_plus_4, jump_pc, shift_pc, branch_pc, final_pc, next_pc;

initial begin
	pc = 32'b0;
end
 
//assign pc_plus_4 = pc + 4;
// calculate next instruction address
wire cout;
adder adder(
    .a(pc),
    .b(32'b00000000000000000000000000000100),
    .sum(pc_plus_4),
    .cin(1'b0),
    .cout(cout)
);

// Calling instruction_block module to get next instruction from memory
instruction_block instruction_block(
    .pc(pc),
    .instruction(instruction)
);

// Calling control unit to generate signals according to instruction
control_unit control_unit(
    .opcode(instruction[31:26]),
    .regDst(regDst),
    .branch(branch),
    .memWrite(memWrite),
    .jump(jump),
    .move(move),
    .memRead(memRead),
    .regWrite(regWrite),
    .ALUsrc(ALUsrc),
    .byteOperations(byteOperations),
    .ALUop(ALUop)
);

// find write_reg value
// 5bit 2to1 mux

assign write_reg = (jump == 1'b1 && instruction[31:26] == 6'b111001) ? 5'b11111 : jal_reg;

mux_6_2to1 muxReg(
    .d0(instruction[20:16]), //rt
    .d1(instruction[15:11]), //rd
    .sel(regDst),
    .out(jal_reg)
);

// Calling Register module to read/write data from/to registers according to instruction type and control signals
register_block register_block(
    .read_reg1(instruction[25:21]), //rs
    .read_reg2(instruction[20:16]), //rt
    .write_reg(write_reg),
    .write_data(write_data), 
    .regWrite(regWrite),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Calling sign_extend module to extend immediate value
sign_extend sign_extend(
    .imm(instruction[15:0]),
    .sign_ext_imm(sign_ext_imm)
);

//  Calling ALU Control module to decide which operation ALU is going to do
alu_control alu_control(
    .function_code(instruction[5:0]),
    .ALUop(ALUop),
    .alu_ctr(alu_ctr)
);

// Before sending data to ALU, we need to decide which data to send
// If ALUsrc is 0, send read_data2 to ALU
mux_32_2to1 muxALU( 
    .d0(read_data2), 
    .d1(sign_ext_imm),
    .sel(ALUsrc),
    .out(alu_src2)
);

// Calling ALU module to perform operation
alu alu(
    .alu_src1(read_data1),
    .alu_src2(alu_src2),
    .alu_ctr(alu_ctr),
    .alu_result(alu_result),
    .zero_bit(zero_bit)
);

// Calling memory_block module to read/write data from/to memory
memory_block memory_block(
    .address(alu_result[17:0]),
    .read_data(read_data),
    .write_data(read_data2),
    .memWrite(memWrite), 
    .memRead(memRead), 
	.byteOperations(byteOperations)
); 

wire [31:0] wire_write_data;
// mux to select data to write in memory
mux_32_2to1 muxMem(
    .d0(alu_result),
    .d1(read_data),
    .sel(memRead),
    .out(wire_write_data)
);

wire [31:0] move_write_data;
// mux to select data to write in register
mux_32_2to1 muxMove(
    .d0(wire_write_data),
    .d1(read_data1),
    .sel(move),
    .out(move_write_data)
);

assign write_data = (jump == 1'b1 && instruction[31:26] == 6'b111001) ? prev_pc : move_write_data;

// Calling shift_left_2 module to shift immediate value
shift_left_2 sl(
    .address(sign_ext_imm),
    .shifted_address(shifted_address)
);

wire cout2;
//assign shift_pc = pc_plus_4 + shifted_address;
adder adder2(
    .a(pc_plus_4),
    .b(shifted_address),
    .sum(shift_pc),
    .cin(1'b0),
    .cout(cout2)
);

// Calling branch module to check if branch is taken or not
wire beq, bne, negate_zero_bit, beq_or_bne;
not not1(negate_zero_bit, zero_bit);

assign beq = (branch == 1'b1 && instruction[31:26] == 6'b100011) ? branch & zero_bit : 1'b0;
assign bne = (branch == 1'b1 && instruction[31:26] == 6'b100111) ? branch & negate_zero_bit : 1'b0;

or or1(beq_or_bne, beq, bne);

// mux to select branch_pc or shift_pc
mux_32_2to1 muxBranch(
    .d0(pc_plus_4),
    .d1(shift_pc),
    .sel(beq_or_bne),
    .out(branch_pc)
); 

// concatenate pc_plus_4[31:28] with instruction[25:0] and 2'b0
//assign jump_pc = {pc_plus_4[31:28], instruction[25:0], 2'b0};
concat concat1(
    .jump_pc(jump_pc),
    .pc_plus_4(pc_plus_4[31:28]),
    .instruction(instruction[25:0])
);

// mux to select final pc
mux_32_2to1 muxJump(
    .d0(branch_pc),
    .d1(jump_pc), 
    .sel(jump),
    .out(final_pc) 
); 

// JR instruction implementation
wire jr, regWriteCheck;
assign jr = (instruction[5:0] == 6'b001000 && instruction[31:26] == 6'b000000) ? 1'b1 : 1'b0;
//regWrite is 0 for jr instruction
not a(regWrite, jr); 
assign next_pc = (jr == 1'b1 && instruction[5:0] == 6'b001000 && instruction[31:26] == 6'b000000) ? read_data1 : final_pc;

// Calling PC module to get next pc
always @(posedge clock) begin
    // Assign pc_plus_4 to prev_pc when a jump instruction is detected
    if (jump == 1'b1 && instruction[31:26] == 6'b111001) begin
        prev_pc <= pc_plus_4;
    end
    pc <= next_pc; 
end

endmodule
