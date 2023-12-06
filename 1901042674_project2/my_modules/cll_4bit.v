module cll_4bit(
    input [3:0] g,
    input [3:0] p,
    input cin,
    output [3:0] cout
);

// Internal wires for the OR and AND gates
wire p0_cin, p1_g0, p2_g1, p3_g2;
wire p1_p0_cin, p2_p1_g0, p3_p2_g1;
wire p2_p1_p0_cin, p3_p2_p1_g0;

// First level of carry calculations
and and1(p0_cin, p[0], cin);
and and2(p1_g0, p[1], g[0]);
and and3(p2_g1, p[2], g[1]);
and and4(p3_g2, p[3], g[2]);

// Second level of carry calculations
and and5(p1_p0_cin, p[1], p0_cin);
and and6(p2_p1_g0, p[2], p1_g0);
and and7(p3_p2_g1, p[3], p2_g1);

// Third level of carry calculations
and and8(p2_p1_p0_cin, p[2], p1_p0_cin);
and and9(p3_p2_p1_g0, p[3], p2_p1_g0);

// Final carry out calculations
or or1(cout[0], g[0], p0_cin);
or or2(cout[1], g[1], p1_g0, p1_p0_cin);
or or3(cout[2], g[2], p2_g1, p2_p1_g0, p2_p1_p0_cin);
or or4(cout[3], g[3], p3_g2, p3_p2_g1, p3_p2_p1_g0);

endmodule
