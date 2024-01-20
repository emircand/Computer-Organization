module alu_control (
    output [2:0] alu_ctr,
    input [5:0] function_code,
    input [2:0] ALUop
);

    wire [2:0] not_ALUop;
    wire andi, ori, addi, subi, slti;
    
    // Inverting ALUop bits
    not(not_ALUop[0], ALUop[0]);
    not(not_ALUop[1], ALUop[1]);
    not(not_ALUop[2], ALUop[2]);

    // ANDI operation (ALUop = 000)
    and(andi, not_ALUop[2], not_ALUop[1], not_ALUop[0]);
    // ORI operation (ALUop = 001)
    and(ori, not_ALUop[2], not_ALUop[1], ALUop[0]);
    // ADDI operation (ALUop = 101)
    and(addi, ALUop[2], not_ALUop[1], ALUop[0]);
    // SUBI operation (ALUop = 110)
    and(subi, ALUop[2], ALUop[1], not_ALUop[0]);
    // SLTI operation (ALUop = 100)
    and(slti, ALUop[2], not_ALUop[1], not_ALUop[0]);
    
    // R-type operation (ALUop = 111), directly pass function_code
    wire r_and, r_or, r_add, r_sub, r_slt, r_jr;
    wire [5:0] func_not;
    not(func_not[0], function_code[0]);
    not(func_not[1], function_code[1]);
    not(func_not[2], function_code[2]);
    not(func_not[3], function_code[3]);
    not(func_not[4], function_code[4]);
    not(func_not[5], function_code[5]);
    // add -> 000010
    and(r_add, func_not[5], func_not[4], func_not[3], func_not[2], function_code[1], func_not[0]);
    // sub -> 000011
    and(r_sub, func_not[5], func_not[4], func_not[3], func_not[2], function_code[1], function_code[0]);
    // and -> 000100
    and(r_and, func_not[5], func_not[4], func_not[3], function_code[2], func_not[1], func_not[0]);
    // or -> 000101
    and(r_or, func_not[5], func_not[4], func_not[3], function_code[2], func_not[1], function_code[0]);
    // slt -> 000111
    and(r_slt, func_not[5], func_not[4], func_not[3], function_code[2], function_code[1], function_code[0]);
    // jr -> 001000
    and(r_jr, func_not[5], func_not[4], function_code[3], func_not[2], func_not[1], func_not[0]);

    // if aluop is not 111, then it is not R-type
    wire r_add_ALUop, r_sub_ALUop, r_or_ALUop, r_jr_ALUop;
    and(r_add_ALUop, r_add, ALUop[2], ALUop[1], ALUop[0]);
    and(r_sub_ALUop, r_sub, ALUop[2], ALUop[1], ALUop[0]);
    and(r_or_ALUop, r_or, ALUop[2], ALUop[1], ALUop[0]);
    and(r_jr_ALUop, r_jr, ALUop[2], ALUop[1], ALUop[0]);

    // alu_ctr[0]
    or(alu_ctr[0], ori, addi, r_or_ALUop, r_add_ALUop);

    // alu_ctr[1]
    or(alu_ctr[1], subi, r_sub_ALUop, r_jr_ALUop);

    // alu_ctr[2]
    or(alu_ctr[2], subi, addi, slti, r_slt, r_add_ALUop, r_sub_ALUop, r_jr_ALUop);
    
endmodule
