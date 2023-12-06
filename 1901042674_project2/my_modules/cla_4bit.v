module cla_4bit(
  input [3:0] a, b,
  input cin,
  output [3:0] sum, g, p,
  output cout
);
wire [3:0] c;

//Instantiate the carry lookahead logic

cll_4bit cll(
  .g(g),
  .p(p),
  .cin(cin),
  .cout(c)
);

// Instantiate full adders
fa fa0(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .g(g[0]), .p(p[0]));
fa fa1(.a(a[1]), .b(b[1]), .cin(c[0]), .sum(sum[1]), .g(g[1]), .p(p[1]));
fa fa2(.a(a[2]), .b(b[2]), .cin(c[1]), .sum(sum[2]), .g(g[2]), .p(p[2]));
fa fa3(.a(a[3]), .b(b[3]), .cin(c[2]), .sum(sum[3]), .g(g[3]), .p(p[3]));

// Logic for cout
buf buf_cout(cout, c[3]);

endmodule
