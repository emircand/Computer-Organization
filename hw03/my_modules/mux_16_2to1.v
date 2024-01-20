module mux_16_2to1 (
    input [15:0] d0, d1,
    input sel,
    output [15:0] out
);

mux2to1 mux1(.a(d0[0]), .b(d1[0]), .s(sel), .res(out[0]));
mux2to1 mux2(.a(d0[1]), .b(d1[1]), .s(sel), .res(out[1]));
mux2to1 mux3(.a(d0[2]), .b(d1[2]), .s(sel), .res(out[2]));
mux2to1 mux4(.a(d0[3]), .b(d1[3]), .s(sel), .res(out[3]));
mux2to1 mux5(.a(d0[4]), .b(d1[4]), .s(sel), .res(out[4]));
mux2to1 mux6(.a(d0[5]), .b(d1[5]), .s(sel), .res(out[5]));
mux2to1 mux7(.a(d0[6]), .b(d1[6]), .s(sel), .res(out[6]));
mux2to1 mux8(.a(d0[7]), .b(d1[7]), .s(sel), .res(out[7]));
mux2to1 mux9(.a(d0[8]), .b(d1[8]), .s(sel), .res(out[8]));
mux2to1 mux10(.a(d0[9]), .b(d1[9]), .s(sel), .res(out[9]));
mux2to1 mux11(.a(d0[10]), .b(d1[10]), .s(sel), .res(out[10]));
mux2to1 mux12(.a(d0[11]), .b(d1[11]), .s(sel), .res(out[11]));
mux2to1 mux13(.a(d0[12]), .b(d1[12]), .s(sel), .res(out[12]));
mux2to1 mux14(.a(d0[13]), .b(d1[13]), .s(sel), .res(out[13]));
mux2to1 mux15(.a(d0[14]), .b(d1[14]), .s(sel), .res(out[14]));
mux2to1 mux16(.a(d0[15]), .b(d1[15]), .s(sel), .res(out[15]));

endmodule
