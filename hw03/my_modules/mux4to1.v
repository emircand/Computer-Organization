module mux4to1(
    output res,
    input a, b, c, d,
    input s0, s1
);
wire not_s0, not_s1;
wire and0, and1, and2, and3;

not(not_s0, s0);
not(not_s1, s1);

and(and0, a, not_s1, not_s0);
and(and1, b, not_s1, s0);
and(and2, c, s1, not_s0);
and(and3, d, s1, s0);

or(res, and0, and1, and2, and3);
endmodule
