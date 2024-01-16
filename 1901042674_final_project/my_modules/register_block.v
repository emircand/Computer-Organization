module register_block(
    output [31:0] read_data1, 
    output [31:0] read_data2, 
    input [31:0] write_data, 
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input regWrite,
    input [4:0] write_reg
);
    parameter REG_FILE_SIZE = 32;
    reg [31:0] registers_mem [0:REG_FILE_SIZE-1];  // Memory array for registers

    // Read data from registers
    assign read_data1 = registers_mem[read_reg1];
    assign read_data2 = registers_mem[read_reg2];
    
    // always @(*) begin
    //     read_data1 <= registers_mem[read_reg1];
    //     read_data2 <= registers_mem[read_reg2];
    // end

    // Write data to registers
    always @(posedge regWrite) begin
        registers_mem[write_reg] <= write_data;
    end
endmodule