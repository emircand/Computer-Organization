module mux8to1(
    output res,
    input a, b, c, d, e, f, g, h,
    input [2:0] aluop
);
wire not_s2, temp0, temp1;

// Instantiate two 4-to-1 multiplexers
mux4to1 Mux0 (temp0, a, b, c, d, aluop[0], aluop[1]);
mux4to1 Mux1 (temp1, e, f, g, h, aluop[0], aluop[1]);

// Final 2-to-1 multiplexer to select between the outputs of the two 4-to-1 multiplexers
mux2to1 MuxFinal (res, temp0, temp1, aluop[2]);

endmodule
