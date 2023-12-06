module adder(
 input [31:0] a, b,
 input cin,
 output [31:0] sum,
 output cout
);

wire [3:0] carry;

cla_8bit cla0(.a(a[7:0]), .b(b[7:0]), .cin(cin), .sum(sum[7:0]), .cout(carry[0]));
cla_8bit cla1(.a(a[15:8]), .b(b[15:8]), .cin(carry[0]), .sum(sum[15:8]), .cout(carry[1]));
cla_8bit cla2(.a(a[23:16]), .b(b[23:16]), .cin(carry[1]), .sum(sum[23:16]), .cout(carry[2]));
cla_8bit cla3(.a(a[31:24]), .b(b[31:24]), .cin(carry[2]), .sum(sum[31:24]), .cout(carry[3]));

buf buffer0(cout, carry[3]);

endmodule
