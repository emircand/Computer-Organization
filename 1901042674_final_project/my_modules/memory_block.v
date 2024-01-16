// module memory_block (
//     output reg [31:0] read_data,
//     input [17:0] address,
//     input [31:0] write_data,
//     input memRead,
//     input memWrite,
//     input byteOperations 
// );   
//     reg [31:0] memory [0:31];  // Memory array 2^18 = 262144 words
      
//     // Read/Write data from memory
//     always @(*) begin 
//         if (memWrite) begin   
//             if (byteOperations) begin
//                 // Store byte operation
//                 memory[address] <= write_data[7:0];
//             end else begin
//                 // Store word operation
//                 memory[address] <= write_data;
//             end
//         end
//         else if (memRead) begin
//             if (byteOperations) begin
//                 // Load byte operation
//                 read_data <= {24'b0, memory[address]};
//             end else begin
//                 // Load word operation
//                 read_data <= memory[address];
//             end
//         end
//     end

// endmodule

module memory_block (
    output reg [31:0] read_data,
    input [17:0] address,
    input [31:0] write_data,
    input memRead, 
    input memWrite,
    input byteOperations
);  
    reg [7:0] memory [0:1024];  // Memory array 

    // Read data from memory
    always @(posedge memRead) begin
            // Read operation
            if (byteOperations) begin
                // Load byte operation
                read_data <= {24'b0, memory[address]};
            end else begin
                read_data <= {memory[address[17:2]+3], memory[address[17:2]+2], memory[address[17:2]+1], memory[address[17:2]]};
            end
    end  

    // Write data to memory
    always @(posedge memWrite) begin
        if (byteOperations) begin
            // Write byte operation
            memory[address] <= write_data[7:0];
        end else begin
            // Write word operation
            memory[address] <= write_data[7:0];
            memory[address[17:2]+1] <= write_data[15:8];
            memory[address[17:2]+2] <= write_data[23:16];
            memory[address[17:2]+3] <= write_data[31:24]; 
        end
    end
endmodule
