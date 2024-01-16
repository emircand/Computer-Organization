`timescale 1ns / 1ps
module mips_tb();
    // Clock Signal 
    reg clock;
    // Instantiating the MIPS module
    mips mips(clock);

    // Initialization block for setting up the clock
    initial begin  
        // Load memory contents 
        $readmemb("instructions.mem", mips.instruction_block.instructions_mem);
        $readmemb("registers.mem", mips.register_block.registers_mem);
        $readmemb("memory.mem", mips.memory_block.memory);
        clock = 1'b0; // Initialize the clock to 0  
        forever #5 clock = ~clock;
    end

    initial begin
        #5;
        
        #70 $finish;
    end

    always @(posedge clock) begin
        $display("~~~~~~~~~~~~~~~");
        $display("PC(int): %2d | Instruction: %32b | alu_ctr: %3b | ALUop: %3b",
                mips.pc, 
                mips.instruction,
                mips.alu_ctr,
                mips.ALUop);
        if(mips.instruction[31:26] == 6'b000000) begin
            // Display information for R-type instruction
            $display("Opcode: %6b | Rs: %5b($%2d) | Rt: %5b($%2d) | Rd: %5b($%2d) | Func: %6b", 
                mips.instruction[31:26], 
                mips.instruction[25:21], mips.instruction[25:21], 
                mips.instruction[20:16], mips.instruction[20:16], 
                mips.instruction[15:11], mips.instruction[15:11], 
                mips.instruction[5:0]);
        end
        else begin 
            // Display information for I-type instruction
            $display("Opcode: %6b | Rs: %5b($%2d) | Rt: %5b($%2d) | Immediate  : %16b",
                mips.instruction[31:26], 
                mips.instruction[25:21], mips.instruction[25:21], 
                mips.instruction[20:16], mips.instruction[20:16], 
                mips.instruction[15:0]);
        end
        $display("~~~~~~~~~~~~~~~register block~~~~~~~~~~~~~~~");
        $display("regWrite: %1b", mips.regWrite);
        $display("regDst: %1b", mips.regDst);
        $display("read_reg1: %5b", mips.register_block.read_reg1);
        $display("read_reg2: %5b", mips.register_block.read_reg2);
        $display("write_reg: %5b", mips.write_reg);
        $display("write_data: %32b", mips.write_data);
        $display("read_data1: %32b", mips.read_data1);
        $display("read_data2: %32b", mips.read_data2);
        $display("~~~~~~~~~~~~~~~memory block~~~~~~~~~~~~~~~");
        $display("r_sub: %1b", mips.alu_control.r_sub);
        $display("sub_res: %32b", mips.alu.sub_res);
        $display("alu_result: %32b", mips.alu_result);
        $display("address: %18b", mips.memory_block.address);
        $display("mem_write_data: %32b", mips.memory_block.write_data);
        $display("read_data: %32b", mips.read_data);
        $display("byteOperations: %1b", mips.byteOperations);
        $display("w_write_data: %32b", mips.wire_write_data);
        $display("memWrite: %1b", mips.memWrite);
        $display("memRead: %1b", mips.memRead);
        $display("~~~~~~~~~~~~~~~control unit~~~~~~~~~~~~~~~");
        $display("regDst: %1b", mips.regDst);
        $display("branch: %1b", mips.branch);
        $display("memWrite: %1b", mips.memWrite);
        $display("jump: %1b", mips.jump);
        $display("move: %1b", mips.move);
        $display("memRead: %1b", mips.memRead);
        $display("regWrite: %1b", mips.regWrite);
        $display("ALUsrc: %1b", mips.ALUsrc);
        $display("byteOperations: %1b", mips.byteOperations);
        $display("ALUop: %3b", mips.ALUop);
        $display("~~~~~~~~~~~~~~~pc calculations~~~~~~~~~~~~~~~");
        $display("shift_pc: %d", mips.shift_pc);
        $display("branch_pc: %d", mips.branch_pc);
        $display("jump_pc: %d", mips.jump_pc);
        $display("final_pc: %d", mips.final_pc);
        $display("zero_bit: %1b\n\n\n", mips.zero_bit);   
        $writememb("registers.mem", mips.register_block.registers_mem);
        $writememb("memory.mem", mips.memory_block.memory);
    end

    // // Monitoring block for simulation output
    // initial begin
    //     #5; // Wait for 5 for the initialization to complete
    //     for (i = 0; i < 6; i = i + 1) begin
    //         $display("~~~~~~~~~~~~~~~");
    //         $display("PC(int): %2d | Instruction: %32b | alu_ctr: %3b | ALUop: %3b",
    //                 mips.pc, 
    //                 mips.instruction,
    //                 mips.alu_ctr,
    //                 mips.ALUop);
    //         if(mips.instruction[31:26] == 6'b000000) begin
    //             // Display information for R-type instruction
    //             $display("Opcode: %6b | Rs: %5b($%2d) | Rt: %5b($%2d) | Rd: %5b($%2d) | Func: %6b", 
    //                 mips.instruction[31:26], 
    //                 mips.instruction[25:21], mips.instruction[25:21], 
    //                 mips.instruction[20:16], mips.instruction[20:16], 
    //                 mips.instruction[15:11], mips.instruction[15:11], 
    //                 mips.instruction[5:0]);
    //         end
    //         else begin 
    //             // Display information for I-type instruction
    //             $display("Opcode: %6b | Rs: %5b($%2d) | Rt: %5b($%2d) | Immediate  : %16b",
    //                 mips.instruction[31:26], 
    //                 mips.instruction[25:21], mips.instruction[25:21], 
    //                 mips.instruction[20:16], mips.instruction[20:16], 
    //                 mips.instruction[15:0]);
    //         end
    //         $display("~~~~~~~~~~~~~~~register block~~~~~~~~~~~~~~~");
    //         $display("regWrite: %1b", mips.regWrite);
    //         $display("regDst: %1b", mips.regDst);
    //         $display("read_reg1: %5b", mips.register_block.read_reg1);
    //         $display("read_reg2: %5b", mips.register_block.read_reg2);
    //         $display("write_reg: %5b", mips.write_reg);
    //         $display("write_data: %32b", mips.write_data);
    //         $display("read_data1: %32b", mips.read_data1);
    //         $display("read_data2: %32b", mips.read_data2);
    //         $display("~~~~~~~~~~~~~~~memory block~~~~~~~~~~~~~~~");
    //         $display("r_sub: %1b", mips.alu_control.r_sub);
    //         $display("sub_res: %32b", mips.alu.sub_res);
    //         $display("alu_result: %32b", mips.alu_result);
    //         $display("address: %18b", mips.memory_block.address);
    //         $display("mem_write_data: %32b", mips.memory_block.write_data);
    //         $display("read_data: %32b", mips.read_data);
    //         $display("byteOperations: %1b", mips.byteOperations);
    //         $display("w_write_data: %32b", mips.wire_write_data);
    //         $display("memWrite: %1b", mips.memWrite);
    //         $display("memRead: %1b", mips.memRead);
    //         $display("~~~~~~~~~~~~~~~control unit~~~~~~~~~~~~~~~");
    //         $display("regDst: %1b", mips.regDst);
    //         $display("branch: %1b", mips.branch);
    //         $display("memWrite: %1b", mips.memWrite);
    //         $display("jump: %1b", mips.jump);
    //         $display("move: %1b", mips.move);
    //         $display("memRead: %1b", mips.memRead);
    //         $display("regWrite: %1b", mips.regWrite);
    //         $display("ALUsrc: %1b", mips.ALUsrc);
    //         $display("byteOperations: %1b", mips.byteOperations);
    //         $display("ALUop: %3b", mips.ALUop);
    //         $display("~~~~~~~~~~~~~~~instruction block~~~~~~~~~~~~~~~");
    //         $display("pc: %d", mips.pc);
    //         $display("instruction: %32b", mips.instruction);
    //         $display("pc_plus_4: %d", mips.pc_plus_4);
    //         $display("~~~~~~~~~~~~~~~pc calculations~~~~~~~~~~~~~~~");
    //         $display("shift_pc: %d", mips.shift_pc);
    //         $display("branch_pc: %d", mips.branch_pc);
    //         $display("jump_pc: %d", mips.jump_pc);
    //         $display("final_pc: %d", mips.final_pc);
    //         $display("zero_bit: %1b", mips.zero_bit);   
    //         $writememb("registers.mem", mips.register_block.registers_mem);
    //         $writememb("memory.mem", mips.memory_block.memory);
    //         #10; // Wait for 10 time units for the next instruction
    //     end
    // end
endmodule
