module mux3to1(input wire [2:0] d0, d1, d2, input wire [1:0] sel, output wire [2:0] out);
    wire [2:0] mux1_out;

    mux2to1 mux1(.d0(d0), .d1(d1), .sel(sel[0]), .out(mux1_out));
    mux2to1 mux2(.d0(mux1_out), .d1(d2), .sel(sel[1]), .out(out));
endmodule
