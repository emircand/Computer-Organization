module mux_32_2to1 (
    input [31:0] d0, d1,
    input sel,
    output [31:0] out
);

mux_16_2to1 mux1(.d0(d0[15:0]), .d1(d1[15:0]), .sel(sel), .out(out[15:0]));
mux_16_2to1 mux2(.d0(d0[31:16]), .d1(d1[31:16]), .sel(sel), .out(out[31:16]));

endmodule
