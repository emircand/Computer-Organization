module control_unit(
    output regDst,
    output branch,
    output memRead,
    output jump,
    output move,
    output [2:0] ALUop,
    output memWrite, 
    output ALUsrc,
    output regWrite,
    output byteOperations,
    input [5:0] opcode 
);

// Temporary wires for NOT gates
wire [5:0] opcode_not;

// Declare detection wires for each instruction type
wire r_type, lw, sw, beq, addi, andi, ori, slti, subi, bne,
    lb, sb, j, jal;

// NOT gates for opcode bits
not(opcode_not[0], opcode[0]);
not(opcode_not[1], opcode[1]);
not(opcode_not[2], opcode[2]);
not(opcode_not[3], opcode[3]);
not(opcode_not[4], opcode[4]);
not(opcode_not[5], opcode[5]);

// Detect R-type instructions (opcode == 000000)
and(r_type, opcode_not[0], opcode_not[1], opcode_not[2], opcode_not[3], opcode_not[4], opcode_not[5]);
//Detect I-type instructions (opcode != 000000)
// ADDI -> OPCODE 000010
and(addi, opcode_not[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode[1], opcode_not[0]);
// SUBI -> OPCODE 000011
and(subi, opcode_not[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode[1], opcode[0]);
// ANDI -> OPCODE 000100
and(andi, opcode_not[5], opcode_not[4], opcode_not[3], opcode[2], opcode_not[1], opcode_not[0]);
// ORI -> OPCODE 000101
and(ori, opcode_not[5], opcode_not[4], opcode_not[3], opcode[2], opcode_not[1], opcode[0]);
// SLTI -> OPCODE 000111
and(slti, opcode_not[5], opcode_not[4], opcode_not[3], opcode[2], opcode[1], opcode[0]);
// LW -> OPCODE 001000
and(lw, opcode_not[5], opcode_not[4], opcode[3], opcode_not[2], opcode_not[1], opcode_not[0]);
// SW -> OPCODE 010000
and(sw, opcode_not[5], opcode[4], opcode_not[3], opcode_not[2], opcode_not[1], opcode_not[0]);
// LB -> OPCODE 001001
and(lb, opcode_not[5], opcode_not[4], opcode[3], opcode_not[2], opcode_not[1], opcode[0]);
// SB -> OPCODE 010001
and(sb, opcode_not[5], opcode[4], opcode_not[3], opcode_not[2], opcode_not[1], opcode[0]);
// JUMP -> OPCODE 111000
and(j, opcode[5], opcode[4], opcode[3], opcode_not[2], opcode_not[1], opcode_not[0]);
// JAL -> OPCODE 111001
and(jal, opcode[5], opcode[4], opcode[3], opcode_not[2], opcode_not[1], opcode[0]);
// BEQ -> OPCODE 100011
and(beq, opcode[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode[1], opcode[0]);
// BNE -> OPCODE 100111
and(bne, opcode[5], opcode_not[4], opcode_not[3], opcode[2], opcode[1], opcode[0]);
// MOVE -> OPCODE 100000
and(move, opcode[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode_not[1], opcode_not[0]);

// ALUop[2] is high for addi, ori, slti, addi, lb, sb, lw, sw, R-type, beq, bne, subi
or(ALUop[2], r_type, slti, addi, lb, subi, beq, bne, sb, lw, sw);

// ALUop[1] is high for subi, beq, bne, R-type
or(ALUop[1], subi, beq, bne, r_type);

// ALUop[0] is high for addi, lw, sw, lb, sb, R-type, ori
or(ALUop[0], ori, addi, lw, sw, lb, sb, r_type);

// Register destination selection
or(regDst, r_type);

// Branching logic
or(branch, beq, bne);

//jump logic
or(jump, j, jal);

// Memory control signals
or(memRead, lw, lb);
or(byteOperations, lb, sb);
or(memWrite, sw, sb);

// ALU source selection
or(ALUsrc, addi, andi, ori, slti, subi, lw, lb, move, sw, sb);

// Register writing logic
or(regWrite, r_type, addi, andi, subi, ori, slti, lw, lb, move, jal);

endmodule
