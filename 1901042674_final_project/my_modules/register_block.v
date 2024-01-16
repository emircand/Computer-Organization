module register_block(
    output reg [31:0] read_data1, read_data2, 
    input [31:0] write_data, 
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input regWrite,
    input [4:0] write_reg
);
    reg [31:0] registers_mem [0:31];  // Memory array for registers

    // Read data from registers 
    // (without using input as sensitivity list it causes a conditional loop)
    always @(read_reg1 or read_reg2) begin
        read_data1 = registers_mem[read_reg1];
        read_data2 = registers_mem[read_reg2];
    end

    // Write data to registers
    always @(*) begin
        if (regWrite)
            registers_mem[write_reg] <= write_data;
    end
endmodule
