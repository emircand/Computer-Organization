module memory_block (
    output reg [31:0] read_data,
    input [17:0] address,
    input [31:0] write_data,
    input memRead, 
    input memWrite,
    input byteOperations
);  
    reg [7:0] memory [0:1024];  // Memory array 
    //reg [7:0] memory [0:262143];  // 256 KB Memory array

    // Read data from memory
    always @(memRead) begin
            // Read operation  
            if (byteOperations) begin
                // Load byte operation 
                read_data <= {24'b0, memory[address[17:2]]};
            end else begin
                read_data <= {memory[address[17:2]*4+3], memory[address[17:2]*4+2], memory[address[17:2]*4+1], memory[address[17:2]*4]};
            end
    end   

    // Write data to memory
    always @(memWrite) begin
        if (byteOperations) begin
            // Write byte operation
            memory[address[17:0]] <= write_data[7:0];
        end else begin
            // Write word operation
            memory[address[17:2]*4] <= write_data[7:0];
            memory[address[17:2]*4+1] <= write_data[15:8];
            memory[address[17:2]*4+2] <= write_data[23:16];
            memory[address[17:2]*4+3] <= write_data[31:24]; 
        end
    end
endmodule

