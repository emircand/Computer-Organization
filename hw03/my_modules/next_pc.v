module next_pc(
    input wire [31:0] pc,
    input wire clock,
    output reg [31:0] nextPC
);

initial begin
	nextPC = 32'b0;
end

always @(posedge clock) begin
    nextPC <= pc; 
end

endmodule
