module mux_1_6to1(input s0, s1, s2, input d0, d1, d2, d3, d4, d5, output y);
    wire not_s0, not_s1, not_s2, s0_and_s1, s0_and_s2, s1_and_s2, not_s0_and_not_s1, not_s0_and_not_s2, not_s1_and_not_s2;
    wire y0, y1, y2, y3, y4, y5;

    not not_gate_s1(.a(s1), .y(not_s1));
    not not_gate_s2(.a(s2), .y(not_s2));

    and and_gate_s0_s1(.a(s0), .b(s1), .y(s0_and_s1));
    and and_gate_s0_s2(.a(s0), .b(s2), .y(s0_and_s2));
    and and_gate_s1_s2(.a(s1), .b(s2), .y(s1_and_s2));

    and and_gate_not_s0_not_s1(.a(not_s0), .b(not_s1), .y(not_s0_and_not_s1));
    and and_gate_not_s0_not_s2(.a(not_s0), .b(not_s2), .y(not_s0_and_not_s2));
    and and_gate_not_s1_not_s2(.a(not_s1), .b(not_s2), .y(not_s1_and_not_s2));

    and and_gate_y0(.a(d0), .b(not_s0_and_not_s1), .y(y0));
    and and_gate_y1(.a(d1), .b(not_s0_and_not_s2), .y(y1));
    and and_gate_y2(.a(d2), .b(not_s1_and_not_s2), .y(y2));
    and and_gate_y3(.a(d3), .b(s0_and_s1), .y(y3));
    and and_gate_y4(.a(d4), .b(s0_and_s2), .y(y4));
    and and_gate_y5(.a(d5), .b(s1_and_s2), .y(y5));

    or or_gate_y(.a(y0), .b(y1), .c(y2), .d(y3), .e(y4), .f(y5), .y(y));
endmodule
