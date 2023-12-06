module mux2to1(
    output res,
    input a, b,
    input s
);
wire not_s;
wire and0, and1;

not(not_s, s);
and(and0, a, not_s);
and(and1, b, s);

or(res, and0, and1);
endmodule
