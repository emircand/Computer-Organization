module mux_6_2to1 (
    input [4:0] d0, d1,
    input sel,
    output [4:0] out
);

mux2to1 mux1(.a(d0[0]), .b(d1[0]), .s(sel), .res(out[0]));
mux2to1 mux2(.a(d0[1]), .b(d1[1]), .s(sel), .res(out[1]));
mux2to1 mux3(.a(d0[2]), .b(d1[2]), .s(sel), .res(out[2]));
mux2to1 mux4(.a(d0[3]), .b(d1[3]), .s(sel), .res(out[3]));
mux2to1 mux5(.a(d0[4]), .b(d1[4]), .s(sel), .res(out[4]));

endmodule